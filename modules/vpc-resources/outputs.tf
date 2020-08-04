output "vpc" {
  value = aws_vpc.main
}

output "public_subnet" {
  value = aws_subnet.public_subnet
}

output "internet_gateway" {
  value = aws_internet_gateway.main
}
