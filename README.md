# terraform-wireguard

## Prerequisites (MacOS)
Install Wireguard from the [App Store](https://apps.apple.com/ug/app/wireguard/id1451685025?mt=12).

## How to use
Whether targeting AWS or DigitalOcean, the general steps are as follows:

1. Create a `settings.auto.tfvars` with the `ssh_public_key` and `region` variables set.
2. Run `terraform apply`, and copy/paste the `client_config` output into your Wireguard tunnel configuration.
3. That's it!

### AWS
AWS-specific documentation [here](terraform/aws/README.md).

### DigitalOcean
DigitalOcean-specific documentation [here](terraform/do/README.md).