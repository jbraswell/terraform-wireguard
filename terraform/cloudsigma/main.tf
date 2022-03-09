provider "cloudsigma" {
  username = var.username
  password = var.password
  location = var.region
}

provider "wireguard" {}

terraform {
  required_providers {
    cloudsigma = {
      source  = "cloudsigma/cloudsigma"
      version = "~> 1.9.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
