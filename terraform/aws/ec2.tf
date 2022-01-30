resource "aws_instance" "wireguard" {
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = tolist(data.aws_subnet_ids.subnets.ids)[0]
  instance_type               = "t3.nano"
  vpc_security_group_ids      = [aws_security_group.wireguard.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.wireguard.name
  user_data                   = data.template_cloudinit_config.wireguard.rendered

  tags = {
    Name = "wireguard"
  }
}

resource "aws_iam_role" "wireguard" {
  name               = "wireguard-${terraform.workspace}"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}

resource "aws_iam_policy" "wireguard" {
  name   = "wireguard-${terraform.workspace}"
  policy = data.aws_iam_policy_document.wireguard.json
}

resource "aws_iam_role_policy_attachment" "wireguard" {
  role       = aws_iam_role.wireguard.name
  policy_arn = aws_iam_policy.wireguard.arn
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.wireguard.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "wireguard" {
  name = "wireguard-${terraform.workspace}"
  role = aws_iam_role.wireguard.name
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_cloudinit_config" "wireguard" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = <<EOF
#cloud-config

packages:
  - awscli
  - jq
  - wireguard
EOF
  }

  part {
    content_type = "text/x-shellscript"
    content      = <<TFEOF
#!/bin/bash

privatekey=$(aws ssm get-parameter --region=us-east-1 --name="/wireguard/privatekey" --with-decryption | jq -r .Parameter.Value)

cat << EOF > /etc/wireguard/wg0.conf
[Interface]
Address = 10.10.10.1/32
ListenPort = 51820
PrivateKey = $${privatekey}
PostUp = sysctl -w net.ipv4.ip_forward=1
PostUp = sysctl -w net.ipv6.conf.all.forwarding=1
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o ens5 -j MASQUERADE; ip6tables -D FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -D POSTROUTING -o ens5 -j MASQUERADE

[Peer]
PublicKey = 2M8lMDqeA4aZXKx1OtRV7LjJf42oaqhNXuJaxdkDFX0=
AllowedIPs = 10.10.10.2/32
EOF

chmod 600 /etc/wireguard/wg0.conf
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0
TFEOF
  }
}
