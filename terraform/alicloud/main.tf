provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

provider "wireguard" {}

terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.150.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
