provider "cloudstack" {
  api_url    = var.api_url
  api_key    = var.api_key
  secret_key = var.secret_key
}

provider "wireguard" {}

terraform {
  required_providers {
    cloudstack = {
      source  = "cloudstack/cloudstack"
      version = "~> 0.4.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
