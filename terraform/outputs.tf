output wireguard_instance_id {
  value = aws_instance.wireguard.id
}

output wireguard_ip {
  value = aws_instance.wireguard.public_ip
}
