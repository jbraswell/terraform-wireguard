<!-- BEGIN_TF_DOCS -->
# Hostinger

Hostinger requires an API token. This can be set via the `HOSTINGER_API_TOKEN` environment variable.

Use the `hostinger_vps_data_centers` data source to find the data center ID for the `region` variable. Use the `hostinger_vps_plans` data source to find available plans.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hostinger"></a> [hostinger](#requirement\_hostinger) | ~> 0.1.22 |
| <a name="requirement_wireguard"></a> [wireguard](#requirement\_wireguard) | ~> 0.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.5 |
| <a name="provider_hostinger"></a> [hostinger](#provider\_hostinger) | 0.1.22 |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | 0.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hostinger_vps.wireguard](https://registry.terraform.io/providers/hostinger/hostinger/latest/docs/resources/vps) | resource |
| [hostinger_vps_post_install_script.wireguard](https://registry.terraform.io/providers/hostinger/hostinger/latest/docs/resources/vps_post_install_script) | resource |
| [hostinger_vps_ssh_key.wireguard](https://registry.terraform.io/providers/hostinger/hostinger/latest/docs/resources/vps_ssh_key) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [external_external.qr](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clients"></a> [clients](#input\_clients) | Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server. | `map(string)` | <pre>{<br>  "default": "10.10.10.2"<br>}</pre> | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The FQDN hostname for the wireguard server. | `string` | `"wireguard.example.com"` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | The VPS plan to use. Use the hostinger\_vps\_plans data source to list available plans. | `string` | `"hostingercom-vps-kvm2-usd-1m"` | no |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired data center ID. Use the hostinger\_vps\_data\_centers data source to list available data centers. | `number` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
| <a name="output_client_config_qr_codes"></a> [client\_config\_qr\_codes](#output\_client\_config\_qr\_codes) | Client configuration qr codes. |
<!-- END_TF_DOCS -->