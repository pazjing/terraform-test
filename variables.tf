variable "region" {
  #default = "ap-southeast-2"
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "vpc_cidr_block" {
  default = "10.3.0.0/16"
}

variable "public_subnet_cidr_block" {
  default = "10.3.1.0/24"
}

variable "availability_zone" {
  default = "ap-southeast-2a"
}

variable "ssh_publish_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCLOI1/qvy0kFJGlYKtmwQti1YSHhRz2jLmRei5GYAm/H1XpcsrU2vA4pgiRejmwYx1WW2RJZOd8dDwAPrJKGZtm1W3HSaZrX+0JytW2uAQgPIofp5zZYlw0G5Z8iFLUL7iWNwh9x8KLqmnAz2REFGYDYSlOY+I+tjQZGjjAGgWTxBQwDW6Ct2jESztHvXKtpMoPu8GvOb8Q5zMN5oaeQJF8h+hesNJmZUbABjBgn32VjqHakoWqLpwsSKCxIlT+w5pxSShRgi2gkSqJ3OG/Xd/M7P6+i1z7woaTV58sYkyFyDqjaTv5gmgWPFKv6yPCjZZtoYUvKR1B8a6fySS4AP3 terraform_ssh"
  type = string
}

variable "ssh_key_name" {
  default = "terraform_ssh"
  type = string
}
