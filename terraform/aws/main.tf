provider "aws" {
  region = var.region
}

provider "wireguard" {}

terraform {
  required_providers {
    wireguard = {
      source = "OJFord/wireguard"
    }
  }
}
