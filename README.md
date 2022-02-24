# terraform-wireguard

## Prerequisites
Install Wireguard with the os of your choice from [WireGuard](https://www.wireguard.com/install/).

## How to use
Whether targeting any cloud provider, the general steps are as follows:

1. Create a `settings.auto.tfvars` with the `ssh_public_key` and `region` variables set.
2. Run `terraform apply`, and copy/paste the `client_config` output into your Wireguard tunnel configuration.
3. That's it!


### AlibabaCloud
AlibabaCloud-specific documentation [here](terraform/alicloud/README.md).

### AWS
AWS-specific documentation [here](terraform/aws/README.md).

### Azure
Azure-specific documentation [here](terraform/azure/README.md).

### CloudStack
CloudStack-specific documentation [here](terraform/cloudstack/README.md).

### DigitalOcean
DigitalOcean-specific documentation [here](terraform/do/README.md).

### Exoscale
Exoscale-specific documentation [here](terraform/exoscale/README.md).

### GCP
GCP-specific documentation [here](terraform/gcp/README.md).

### Generic
Generic-specific documentation [here](terraform/generic/README.md).

### Hetzner
Hetzner-specific documentation [here](terraform/hetzner/README.md).

### IBM
IBM-specific documentation [here](terraform/ibm/README.md).

### Linode
Linode-specific documentation [here](terraform/linode/README.md).

### OpenStack
OpenStack-specific documentation [here](terraform/openstack/README.md).

### OCI
OCI-specific documentation [here](terraform/oci/README.md).

### Upcloud
Upcloud-specific documentation [here](terraform/upcloud/README.md).

### Scaleway
Scaleway-specific documentation [here](terraform/scaleway/README.md).

### Serverspace
Serverspace-specific documentation [here](terraform/serverspace/README.md).

### Vultr
Vultr-specific documentation [here](terraform/vultr/README.md).
