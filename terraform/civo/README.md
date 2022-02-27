## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_civo"></a> [civo](#requirement\_civo) | ~> 1.0.0 |
| <a name="requirement_wireguard"></a> [wireguard](#requirement\_wireguard) | ~> 0.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_civo"></a> [civo](#provider\_civo) | 1.0.12 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.2.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | 0.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [civo_firewall.wireguard](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/firewall) | resource |
| [civo_firewall_rule.egress_tcp](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/firewall_rule) | resource |
| [civo_firewall_rule.egress_udp](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/firewall_rule) | resource |
| [civo_firewall_rule.ssh](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/firewall_rule) | resource |
| [civo_firewall_rule.wireguard](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/firewall_rule) | resource |
| [civo_instance.wireguard](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/instance) | resource |
| [civo_ssh_key.wireguard](https://registry.terraform.io/providers/civo/civo/latest/docs/resources/ssh_key) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [civo_disk_image.ubuntu](https://registry.terraform.io/providers/civo/civo/latest/docs/data-sources/disk_image) | data source |
| [civo_network.default](https://registry.terraform.io/providers/civo/civo/latest/docs/data-sources/network) | data source |
| [external_external.qr](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_civo_token"></a> [civo\_token](#input\_civo\_token) | Civo authentication token. | `string` | n/a | yes |
| <a name="input_clients"></a> [clients](#input\_clients) | Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server. | `map(string)` | <pre>{<br>  "default": "10.10.10.2",<br>  "home": "10.10.10.3"<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. Valid regions at https://www.civo.com/learn/civo-regions. | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
| <a name="output_client_config_qr_codes"></a> [client\_config\_qr\_codes](#output\_client\_config\_qr\_codes) | Client configuration qr codes. |
