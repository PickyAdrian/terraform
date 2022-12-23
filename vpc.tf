
provider "google" {
  project = var.project_id
  region  = var.region
}

# VPC
resource "google_compute_network" "vpc" {
  name = "${var.project_id}-vpc-gke"
  description = "Default description for the vpc"
  auto_create_subnetworks = "false"
  mtu = 1460
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name = "${var.project_id}-subnet"
  description = "Default description for subnet"
  region = var.region
  network = google_compute_network.vpc.name
  ip_cidr_range = var.ip_cidr_range
}
