terraform {
  backend "s3" {
    bucket = "jbraswell-tfstate"
    key    = "wireguard.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "ubuntu" {
  owners = ["099720109477"]

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_region" "current" {}

data "http" "ip" {
  url = "https://ifconfig.me/all.json"

  request_headers = {
    Accept = "application/json"
  }
}

locals {
  myip = "${jsondecode(data.http.ip.body).ip_addr}/32"
}
