provider "google" {
 credentials = "${file("mstackx-714182dd32e7.json")}"
 project     = "mstackx"
 region      = "us-central1"
}

resource "google_compute_network" "myvpc" {
  name                    = "my-test-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "mysubnet" {
  name            = "my-test-subnet"
  network         = "${google_compute_network.myvpc.name}"
  ip_cidr_range   = var.infra_cidr
}

resource "google_compute_firewall" "internal" {
  name    = "my-allow-firewall-internal"
  priority = 990
  network = "${google_compute_network.myvpc.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "tcp"
  }

  source_ranges = [ "10.240.0.0/24","10.200.0.0/16" ]
}

resource "google_compute_firewall" "external" {
  name    = "my-allow-firewall-external"
  priority = 990
  network = "${google_compute_network.myvpc.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  source_ranges = [ "0.0.0.0/0" ]
}

resource "google_compute_address" "myLBip" {
  name = "my-lb-ip"
}
