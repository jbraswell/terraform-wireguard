provider "hostinger" {}

provider "wireguard" {}

terraform {
  required_providers {
    hostinger = {
      source  = "hostinger/hostinger"
      version = "~> 0.1.22"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
