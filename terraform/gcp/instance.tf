resource "google_compute_instance" "wireguard" {
  name         = "wireguard-${terraform.workspace}"
  machine_type = "e2-small"
  zone         = "${var.region}-b"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.wireguard.address
    }
  }

  metadata = {
    ssh-keys = "wireguard:${var.ssh_public_key}"
  }

  metadata_startup_script = <<EOF
#!/bin/bash
apt-get -y update && apt-get -y install wireguard
${templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })}
EOF

  tags = ["wireguard-${terraform.workspace}"]
}

resource "google_compute_address" "wireguard" {
  name = "wireguard-${terraform.workspace}"
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh-wireguard-${terraform.workspace}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [local.myip]
  target_tags   = ["http-server"]
}


resource "google_compute_firewall" "wireguard" {
  name    = "allow-wireguard-${terraform.workspace}"
  network = "default"

  allow {
    protocol = "udp"
    ports    = ["51820"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["wireguard-${terraform.workspace}"]
}

resource "google_compute_firewall" "egress" {
  name      = "allow-all-egress-wireguard-${terraform.workspace}"
  network   = "default"
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }

  destination_ranges = ["0.0.0.0/0"]
  target_tags        = ["wireguard-${terraform.workspace}"]
}

data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}
