## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_contabo"></a> [contabo](#requirement\_contabo) | >= 0.1.22 |
| <a name="requirement_wireguard"></a> [wireguard](#requirement\_wireguard) | ~> 0.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_contabo"></a> [contabo](#provider\_contabo) | 0.1.22 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.1 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.0 |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | 0.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [contabo_instance.wireguard](https://registry.terraform.io/providers/contabo/contabo/latest/docs/resources/instance) | resource |
| [contabo_secret.password](https://registry.terraform.io/providers/contabo/contabo/latest/docs/resources/secret) | resource |
| [contabo_secret.wireguard](https://registry.terraform.io/providers/contabo/contabo/latest/docs/resources/secret) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [contabo_image.ubuntu_22_04](https://registry.terraform.io/providers/contabo/contabo/latest/docs/data-sources/image) | data source |
| [external_external.qr](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clients"></a> [clients](#input\_clients) | Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server. | `map(string)` | <pre>{<br>  "default": "10.10.10.2"<br>}</pre> | no |
| <a name="input_oauth2_client_id"></a> [oauth2\_client\_id](#input\_oauth2\_client\_id) | Your API client ID. | `string` | n/a | yes |
| <a name="input_oauth2_client_secret"></a> [oauth2\_client\_secret](#input\_oauth2\_client\_secret) | Your API client secret. | `string` | n/a | yes |
| <a name="input_oauth2_pass"></a> [oauth2\_pass](#input\_oauth2\_pass) | Your account users password. | `string` | n/a | yes |
| <a name="input_oauth2_user"></a> [oauth2\_user](#input\_oauth2\_user) | Your account username [email].. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. Valid regions at https://contabo.com/en/locations/, to get region ids use their cli and run `cntb get datacenters`. | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
| <a name="output_client_config_qr_codes"></a> [client\_config\_qr\_codes](#output\_client\_config\_qr\_codes) | Client configuration qr codes. |
