## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudstack"></a> [cloudstack](#requirement\_cloudstack) | ~> 0.4.0 |
| <a name="requirement_wireguard"></a> [wireguard](#requirement\_wireguard) | ~> 0.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.2.0 |
| <a name="provider_cloudstack"></a> [cloudstack](#provider\_cloudstack) | 0.4.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.2.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | 0.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudstack_instance.wireguard](https://registry.terraform.io/providers/cloudstack/cloudstack/latest/docs/resources/instance) | resource |
| [cloudstack_security_group.wireguard](https://registry.terraform.io/providers/cloudstack/cloudstack/latest/docs/resources/security_group) | resource |
| [cloudstack_security_group_rule.wireguard](https://registry.terraform.io/providers/cloudstack/cloudstack/latest/docs/resources/security_group_rule) | resource |
| [cloudstack_ssh_keypair.wireguard](https://registry.terraform.io/providers/cloudstack/cloudstack/latest/docs/resources/ssh_keypair) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [cloudinit_config.wireguard](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [external_external.qr](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Cloudstack access key. | `string` | n/a | yes |
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | Cloudstack api url. | `string` | n/a | yes |
| <a name="input_clients"></a> [clients](#input\_clients) | Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server. | `map(string)` | <pre>{<br>  "default": "10.10.10.2",<br>  "home": "10.10.10.3"<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. The cloudstack zone to deploy to. | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Cloudstack secret key. | `string` | n/a | yes |
| <a name="input_service_offering"></a> [service\_offering](#input\_service\_offering) | Cloudstack service offering (instance type). | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |
| <a name="input_template"></a> [template](#input\_template) | Cloudstack template (image). | `string` | `"Linux Ubuntu 20.04 LTS 64-bit"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
| <a name="output_client_config_qr_codes"></a> [client\_config\_qr\_codes](#output\_client\_config\_qr\_codes) | Client configuration qr codes. |
