provider "serverspace" {
  key = var.api_key
}

provider "wireguard" {}

terraform {
  required_providers {
    serverspace = {
      source  = "itglobalcom/serverspace"
      version = "~> 0.2.2"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
