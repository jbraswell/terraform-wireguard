## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_public_key"></a> [client\_public\_key](#input\_client\_public\_key) | The public key of your wireguard client. Can be derived from the private key with `wg pubkey`. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The wireguard server's desired region. Valid regions at https://docs.aws.amazon.com/directoryservice/latest/admin-guide/regions.html. | `string` | n/a | yes |
| <a name="input_server_private_key"></a> [server\_private\_key](#input\_server\_private\_key) | The private key that will be used for the wireguard server. Can be generated with `wg genkey`. | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH key used to access the wireguard server. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peer_config"></a> [peer\_config](#output\_peer\_config) | Peer block for use in wireguard client configuration. |
| <a name="output_wireguard_public_ip"></a> [wireguard\_public\_ip](#output\_wireguard\_public\_ip) | Public IP address of the wireguard server. |
