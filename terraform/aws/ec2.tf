resource "aws_instance" "wireguard" {
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = tolist(data.aws_subnet_ids.subnets.ids)[0]
  instance_type               = "t3.nano"
  key_name                    = aws_key_pair.wireguard.key_name
  vpc_security_group_ids      = [aws_security_group.wireguard.id]
  associate_public_ip_address = true
  user_data                   = data.cloudinit_config.wireguard.rendered

  tags = {
    Name = "wireguard"
  }
}

resource "aws_security_group" "wireguard" {
  vpc_id = data.aws_vpc.default.id
  name   = "wireguard-${terraform.workspace}"

  ingress {
    from_port   = 51820
    to_port     = 51820
    protocol    = "UDP"
    cidr_blocks = [local.myip]
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
