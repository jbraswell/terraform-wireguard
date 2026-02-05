data "external" "qr" {
  for_each = var.clients

  program = ["${path.module}/../qr.sh"]

  query = {
    config = data.wireguard_config_document.client[each.key].conf
  }
}
