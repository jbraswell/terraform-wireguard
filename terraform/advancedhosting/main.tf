provider "ah" {
  access_token = var.ah_token
}

provider "wireguard" {}

terraform {
  required_providers {
    ah = {
      source  = "advancedhosting/ah"
      version = "~> 0.2.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
