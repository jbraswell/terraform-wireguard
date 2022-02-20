provider "google" {
  project     = var.gcp_project
  credentials = file(var.gcp_auth_file)
  region      = var.region
}

provider "wireguard" {}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.11.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
