terraform {
  backend "s3" {
    bucket = "jbraswell-tfstate"
    key    = "wireguard-do.tfstate"
    region = "us-east-1"
  }
}

provider "digitalocean" {
  token = var.do_token
}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}
