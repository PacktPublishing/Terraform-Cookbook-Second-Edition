terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-07c1207a9d40bc3bd"
  instance_type = "t2.micro"
}