terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      version = "~> 3.27"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }

  backend "s3" {
    bucket = "tfstatebookdemo"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }


}

provider "aws" {
  region = "us-east-2"
}


resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-07c1207a9d40bc3bd-${random_string.random.result}"
  instance_type = "t2.micro"
}