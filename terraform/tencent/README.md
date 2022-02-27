## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | ~> 1.61.0 |
| <a name="requirement_wireguard"></a> [wireguard](#requirement\_wireguard) | ~> 0.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.2.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.2.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | 1.61.13 |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | 0.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_eip.wireguard](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/eip) | resource |
| [tencentcloud_eip_association.wireguard](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/eip_association) | resource |
| [tencentcloud_instance.wireguard](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/instance) | resource |
| [tencentcloud_key_pair.wireguard](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/key_pair) | resource |
| [tencentcloud_security_group.wireguard](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/security_group) | resource |
| [tencentcloud_security_group_rule.egress_tcp](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/security_group_rule) | resource |
| [tencentcloud_security_group_rule.egress_udp](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/security_group_rule) | resource |
| [tencentcloud_security_group_rule.ssh](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/security_group_rule) | resource |
| [tencentcloud_security_group_rule.wireguard](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/security_group_rule) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [cloudinit_config.wireguard](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [external_external.qr](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [tencentcloud_image.ubuntu](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/data-sources/image) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clients"></a> [clients](#input\_clients) | Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server. | `map(string)` | <pre>{<br>  "default": "10.10.10.2"<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. Valid regions at https://intl.cloud.tencent.com/document/product/213/6091. | `string` | n/a | yes |
| <a name="input_secret_id"></a> [secret\_id](#input\_secret\_id) | Tencent secret id. | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Tencent secret key. | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
| <a name="output_client_config_qr_codes"></a> [client\_config\_qr\_codes](#output\_client\_config\_qr\_codes) | Client configuration qr codes. |
