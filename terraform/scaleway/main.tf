provider "scaleway" {
  project_id = var.project_id
  region     = var.region
  zone       = "${var.region}-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "wireguard" {}

terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.2.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
