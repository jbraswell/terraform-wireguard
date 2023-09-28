provider "contabo" {
  oauth2_client_id     = var.oauth2_client_id
  oauth2_client_secret = var.oauth2_client_secret
  oauth2_user          = var.oauth2_user
  oauth2_pass          = var.oauth2_pass
}

provider "wireguard" {}

terraform {
  required_providers {
    contabo = {
      source  = "contabo/contabo"
      version = ">= 0.1.22"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
