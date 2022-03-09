## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudsigma"></a> [cloudsigma](#requirement\_cloudsigma) | ~> 1.9.0 |
| <a name="requirement_wireguard"></a> [wireguard](#requirement\_wireguard) | ~> 0.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudsigma"></a> [cloudsigma](#provider\_cloudsigma) | 1.9.1 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.2.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | 0.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudsigma_drive.ubuntu](https://registry.terraform.io/providers/cloudsigma/cloudsigma/latest/docs/resources/drive) | resource |
| [cloudsigma_server.ubuntu](https://registry.terraform.io/providers/cloudsigma/cloudsigma/latest/docs/resources/server) | resource |
| [local_file.wireguard](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [cloudsigma_library_drive.ubuntu](https://registry.terraform.io/providers/cloudsigma/cloudsigma/latest/docs/data-sources/library_drive) | data source |
| [external_external.qr](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clients"></a> [clients](#input\_clients) | Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server. | `map(string)` | <pre>{<br>  "default": "10.10.10.2"<br>}</pre> | no |
| <a name="input_password"></a> [password](#input\_password) | CloudSigma password. | `string` | n/a | yes |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | The path to your private key for remote-exec. | `string` | `"~/.ssh/id_rsa"` | no |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. Valid regions at https://www.cloudsigma.com/cloud-locations/. | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | CloudSigma username. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
| <a name="output_client_config_qr_codes"></a> [client\_config\_qr\_codes](#output\_client\_config\_qr\_codes) | Client configuration qr codes. |
