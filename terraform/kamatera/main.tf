provider "kamatera" {
  api_client_id = var.secret_id
  api_secret    = var.secret_key
}

provider "wireguard" {}

terraform {
  required_providers {
    kamatera = {
      source  = "Kamatera/kamatera"
      version = "~> 0.7.5"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
