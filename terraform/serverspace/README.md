## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_serverspace"></a> [serverspace](#requirement\_serverspace) | ~> 0.2.2 |
| <a name="requirement_wireguard"></a> [wireguard](#requirement\_wireguard) | ~> 0.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |
| <a name="provider_serverspace"></a> [serverspace](#provider\_serverspace) | 0.2.2 |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | 0.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [serverspace_server.wireguard](https://registry.terraform.io/providers/itglobalcom/serverspace/latest/docs/resources/server) | resource |
| [serverspace_ssh.wireguard](https://registry.terraform.io/providers/itglobalcom/serverspace/latest/docs/resources/ssh) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Serverspace api key. | `string` | n/a | yes |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | The path to your private key for remote-exec. | `string` | `"~/.ssh/id_rsa"` | no |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. Valid regions are Moscow (ds1), Amsterdam (am2), Almaty (kz), New Jersey (nj3). | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
