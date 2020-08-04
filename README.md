Terraform project for EC2 instance
=====================
This repository contains a terraform project that builds an EC2 instance, then deploy and monitor NGINX docker container within it.
* Assumes you have ssh-key pair 
* Assumes you have an AWS account
* Assumes you have AWS account access key and secret key

Inputs
--------------
- `region` - No default value, input is required
- `access_key` - AWS access key. No default value, input is required
- `secret_key` - AWS secret key. No default value, input is required
- `vpc_cidr_block` - VPC cidr block. Default is 10.3.0.0/16
- `public_subnet_cidr_block` - Public subnet cidr block. Default is 10.3.1.0/24
- `availability_zone` - AWS availability zone. Default is ap-southeast-2a
- `ssh_publish_key` -SSH public key. Default value might not be valid for your env. Override with your own one as input 
- `ssh_key_name` -SSH public key. Default value might not be valid for your env. Override with your own one as input 

Outputs
--------------
- `public_ip` - The public IP of the created instance

Usage
-----
SSH private key file with ${ssh_key_name}.pem as name should be put in the same directory as README.md as it is required for deploy

- #### Apply
    `input.tfvars` holds variables which should be overriden with valid ones.
    ```
    terraform init
    terraform apply -var-file="input.tfvars" 
    ```
    ```
    terraform apply -var="region=ap-southeast-2" -var="access_key=<your-aws-access-key>" -var="secret_key=<your-aws-secret-key>" 
    ```
 -    #### Verify 
      - Browse http://<public_ip> to confirm the NIGINX server is up and running
      - Check the deploy log for the word occurs most on the page. Or check the result.txt file after deploy
      - Browse http://<public_ip>/resource.txt for the result of resource.log

    
- #### Destroy
    input.tfvars holds variables which should be overriden with valid ones.
    ```
    terraform destroy -var-file="input.tfvars" 
    ```
    ```
    terraform destroy -var="region=ap-southeast-2" -var="access_key=<your-aws-access-key>" -var="secret_key=<your-aws-secret-key>" 
