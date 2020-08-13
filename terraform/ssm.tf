resource aws_ssm_parameter private_key {
  name  = "/wireguard/privatekey"
  type  = "SecureString"
  value = var.private_key
}
