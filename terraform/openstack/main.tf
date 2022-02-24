provider "openstack" {
  user_name   = var.user_name
  tenant_name = var.tenant_name
  password    = var.password
  auth_url    = var.auth_url
  region      = var.region
}

provider "wireguard" {}

terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.47.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
