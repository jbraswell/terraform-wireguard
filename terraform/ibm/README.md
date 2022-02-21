## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | ~> 1.38.0 |
| <a name="requirement_wireguard"></a> [wireguard](#requirement\_wireguard) | ~> 0.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.2.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.38.2 |
| <a name="provider_wireguard"></a> [wireguard](#provider\_wireguard) | 0.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_floating_ip.wireguard](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_floating_ip) | resource |
| [ibm_is_instance.wireguard](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance) | resource |
| [ibm_is_security_group.wireguard](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group) | resource |
| [ibm_is_security_group_rule.egress_tcp](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.egress_udp](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.ssh](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.wireguard](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_ssh_key.wireguard](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_ssh_key) | resource |
| [ibm_is_subnet.wireguard](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_subnet) | resource |
| [ibm_is_vpc.wireguard](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_vpc) | resource |
| [ibm_is_vpc_address_prefix.wireguard](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_vpc_address_prefix) | resource |
| [wireguard_asymmetric_key.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [wireguard_asymmetric_key.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/resources/asymmetric_key) | resource |
| [cloudinit_config.wireguard](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [ibm_is_image.ubuntu](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_image) | data source |
| [wireguard_config_document.client](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |
| [wireguard_config_document.server](https://registry.terraform.io/providers/OJFord/wireguard/latest/docs/data-sources/config_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iaas_classic_api_key"></a> [iaas\_classic\_api\_key](#input\_iaas\_classic\_api\_key) | The classic api key. | `string` | n/a | yes |
| <a name="input_iaas_classic_username"></a> [iaas\_classic\_username](#input\_iaas\_classic\_username) | the classic username. | `string` | n/a | yes |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | The api key. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. Valid regions at https://cloud.ibm.com/docs/overview?topic=overview-locations . | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |
| <a name="input_subnet_cidr_block"></a> [subnet\_cidr\_block](#input\_subnet\_cidr\_block) | The subnet cidr block to use. | `string` | `"10.0.1.0/24"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Client configuration. |
