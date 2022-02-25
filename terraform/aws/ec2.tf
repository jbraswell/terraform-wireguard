resource "aws_instance" "wireguard" {
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = tolist(data.aws_subnet_ids.subnets.ids)[0]
  instance_type          = "t3.nano"
  key_name               = aws_key_pair.wireguard.key_name
  vpc_security_group_ids = [aws_security_group.wireguard.id]
  user_data              = data.cloudinit_config.wireguard.rendered

  tags = {
    Name = "wireguard"
  }
}

resource "aws_eip" "wireguard" {
  vpc = true
}

resource "aws_eip_association" "wireguard" {
  instance_id   = aws_instance.wireguard.id
  allocation_id = aws_eip.wireguard.id
}

resource "aws_security_group" "wireguard" {
  vpc_id = data.aws_vpc.default.id
  name   = "wireguard-${terraform.workspace}"

  ingress {
    from_port   = 51820
    to_port     = 51820
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [local.myip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "cloudinit_config" "wireguard" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = <<EOF
#cloud-config

packages:
  - wireguard
EOF
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })
  }
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
