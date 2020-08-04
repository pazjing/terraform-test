
provider "aws" {
  region      = var.region
  access_key  = var.access_key
  secret_key  = var.secret_key

}

# Create VPC, Internet Gateway, Public Subnet, Public Route, Network ACL
module "vpc-resources" {
  source                   = "./modules/vpc-resources"
  vpc_cidr_block           = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  availability_zone        = var.availability_zone
}

# Create security group for public access instance
resource "aws_security_group" "sg_allow_http_ssh" {
  name        = "sg_allow_http_ssh"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = module.vpc-resources.vpc.id

  ingress {
    description = "HTTP is open to internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH is open to internet, need to change"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform practice"
  }
}

resource "aws_key_pair" "default" {
  key_name = var.ssh_key_name
  public_key = var.ssh_publish_key
}

data "aws_ami" "linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "webserver" {
  ami                    = data.aws_ami.linux_ami.id
  availability_zone      = var.availability_zone
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_allow_http_ssh.id]
  key_name               = aws_key_pair.default.key_name
  subnet_id              = module.vpc-resources.public_subnet.id
  associate_public_ip_address = true
  user_data              = file("scripts4ec2/setup_server.sh")

  tags = {
    Name = "terraform practice"
  }
}

# Interact with EC2 instance
module "provisioners" {
  source       = "./modules/provisioners"
  instance_ip  = aws_instance.webserver.public_ip
  ssh_key_name = var.ssh_key_name
}


output "public_ip" {
    value = aws_instance.webserver.public_ip
}
