## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ionoscloud"></a> [ionoscloud](#requirement\_ionoscloud) | ~> 6.1.0 |
| <a name="requirement_wireguard"></a> [wireguard](#requirement\_wireguard) | ~> 0.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.2.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.2.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |
| <a name="provider_ionoscloud"></a> [ionoscloud](#provider\_ionoscloud) | 6.1.4 |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | 0.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ionoscloud_datacenter.wireguard](https://registry.terraform.io/providers/ionos-cloud/ionoscloud/latest/docs/resources/datacenter) | resource |
| [ionoscloud_firewall.ssh](https://registry.terraform.io/providers/ionos-cloud/ionoscloud/latest/docs/resources/firewall) | resource |
| [ionoscloud_firewall.wireguard](https://registry.terraform.io/providers/ionos-cloud/ionoscloud/latest/docs/resources/firewall) | resource |
| [ionoscloud_ipblock.wireguard](https://registry.terraform.io/providers/ionos-cloud/ionoscloud/latest/docs/resources/ipblock) | resource |
| [ionoscloud_lan.wireguard](https://registry.terraform.io/providers/ionos-cloud/ionoscloud/latest/docs/resources/lan) | resource |
| [ionoscloud_server.wireguard](https://registry.terraform.io/providers/ionos-cloud/ionoscloud/latest/docs/resources/server) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [cloudinit_config.wireguard](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [external_external.qr](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [ionoscloud_image.ubuntu](https://registry.terraform.io/providers/ionos-cloud/ionoscloud/latest/docs/data-sources/image) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clients"></a> [clients](#input\_clients) | Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server. | `map(string)` | <pre>{<br>  "default": "10.10.10.2"<br>}</pre> | no |
| <a name="input_password"></a> [password](#input\_password) | Ionos password. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. Valid regions at https://cloud.ionos.com/data-centers. | `string` | n/a | yes |
| <a name="input_ssh_key_path"></a> [ssh\_key\_path](#input\_ssh\_key\_path) | The SSH key path, ex. /home/user/.ssh/id\_rsa.pub. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Ionos username. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
| <a name="output_client_config_qr_codes"></a> [client\_config\_qr\_codes](#output\_client\_config\_qr\_codes) | Client configuration qr codes. |
