## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vultr"></a> [vultr](#requirement\_vultr) | ~> 2.9.1 |
| <a name="requirement_wireguard"></a> [wireguard](#requirement\_wireguard) | ~> 0.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.2.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.2.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |
| <a name="provider_vultr"></a> [vultr](#provider\_vultr) | 2.9.1 |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | 0.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vultr_firewall_group.wireguard](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/firewall_group) | resource |
| [vultr_firewall_rule.ssh](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/firewall_rule) | resource |
| [vultr_firewall_rule.wireguard](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/firewall_rule) | resource |
| [vultr_instance.wireguard](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/instance) | resource |
| [vultr_reserved_ip.wireguard](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/reserved_ip) | resource |
| [vultr_ssh_key.wireguard](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/ssh_key) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [cloudinit_config.wireguard](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [external_external.qr](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [vultr_os.ubuntu](https://registry.terraform.io/providers/vultr/vultr/latest/docs/data-sources/os) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clients"></a> [clients](#input\_clients) | Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server. | `map(string)` | <pre>{<br>  "default": "10.10.10.2"<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. Valid regions at https://api.vultr.com/v2/regions. | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |
| <a name="input_vultr_token"></a> [vultr\_token](#input\_vultr\_token) | Vultr authentication token. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
| <a name="output_client_config_qr_codes"></a> [client\_config\_qr\_codes](#output\_client\_config\_qr\_codes) | Client configuration qr codes. |
