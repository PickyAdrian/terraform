# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-cluster"
  location = var.zone
  remove_default_node_pool = false
  initial_node_count       = 1

    ip_allocation_policy {
        cluster_ipv4_cidr_block = var.ip_cidr_range_gke
        }

  network = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

   node_config {
     machine_type = "g1-small"
     disk_type  = "pd-balanced"
    disk_size_gb = 40   
   }

}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool-g1-small"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes
  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }
    preemptible  = true
    machine_type = "g1-small"
    disk_type  = "pd-standard"
    disk_size_gb = 20
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

# Create a second node_pool
resource "google_container_node_pool" "secondary_nodes" {
  name       = "node-pool-e2-small"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes
  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    labels = {
      env = var.project_id
    }
    preemptible  = true
    machine_type = "e2-small"
    disk_type  = "pd-balanced"
    disk_size_gb = 20
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

# Create a third node_pool
resource "google_container_node_pool" "tertiary_nodes" {
  name       = "node-pool-e2-medium"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  autoscaling {
    min_node_count = 0
    max_node_count = 1
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    labels = {
      env = var.project_id
    }
    spot = true
    machine_type = "e2-medium"
    disk_type  = "pd-balanced"
    disk_size_gb = 20
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
