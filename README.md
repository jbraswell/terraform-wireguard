# terraform-wireguard

## Prerequisites
Install Wireguard with the os of your choice from [WireGuard](https://www.wireguard.com/install/).

## How to use
Whether targeting AWS, Azure, DigitalOcean, GCP, Linode, Oracle or Vultr, the general steps are as follows:

1. Create a `settings.auto.tfvars` with the `ssh_public_key` and `region` variables set.
2. Run `terraform apply`, and copy/paste the `client_config` output into your Wireguard tunnel configuration.
3. That's it!

### AWS
AWS-specific documentation [here](terraform/aws/README.md).

### Azure
Azure-specific documentation [here](terraform/azure/README.md).

### DigitalOcean
DigitalOcean-specific documentation [here](terraform/do/README.md).

### GCP
GCP-specific documentation [here](terraform/gcp/README.md).

### Linode
Linode-specific documentation [here](terraform/linode/README.md).

### OCI
OCI-specific documentation [here](terraform/oci/README.md).

### Vultr
Vultr-specific documentation [here](terraform/vultr/README.md).
