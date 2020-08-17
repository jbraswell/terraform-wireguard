terraform {
  backend s3 {
    bucket = "jbraswell-tfstate"
    key    = "wireguard.tfstate"
    region = "us-east-1"
  }
}

provider aws {
  region = "us-east-1"
}

data aws_vpc default {
  default = true
}

data aws_subnet_ids subnets {
  vpc_id = data.aws_vpc.default.id
}

data aws_ami ubuntu {
  owners = ["099720109477"]

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data aws_region current {}

data aws_iam_policy_document ec2_assume_role_policy {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data aws_iam_policy_document wireguard {
  statement {
    actions   = ["ssm:GetParameter", "ssm:PutParameter"]
    resources = ["arn:aws:ssm:${data.aws_region.current.name}:*:/parameter/wireguard/privatekey"]
  }
}
