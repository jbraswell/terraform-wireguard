data aws_route53_zone base {
  name = var.base_domain
}

resource aws_route53_record wireguard {
  zone_id = data.aws_route53_zone.base.zone_id
  name    = "wg.${data.aws_route53_zone.base.name}"
  type    = "A"
  ttl     = "60"
  records = [digitalocean_droplet.wireguard.ipv4_address]
}
