## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_linode"></a> [linode](#provider\_linode) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_firewall.wireguard](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/firewall) | resource |
| [linode_instance.wireguard](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance) | resource |
| [linode_sshkey.wireguard](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/sshkey) | resource |
| [linode_stackscript.wireguard](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/stackscript) | resource |
| [random_string.root_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_linode_token"></a> [linode\_token](#input\_linode\_token) | Linode authentication token. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. Valid regions at https://www.linode.com/docs/api/regions/#regions-list. | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
