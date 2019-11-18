
data "google_client_config" "current" {}

resource "google_container_cluster" "controller" {
  name     = var.name
  location = var.zone
  project  = var.project

  node_version       = var.node_version
  min_master_version = var.node_version

  // There is no option not to have a default node pool
  // Since we want to manage our pools better we will remove the default and add more later
  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_container_node_pool" "workers" {
  count      = var.worker_node_count
  name       = "${var.name}-worker"
  location   = var.zone
  project    = var.project
  cluster    = google_container_cluster.controller.name
  node_count = var.worker_node_count
  version    = var.node_version

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    machine_type = var.worker_machine_type
    image_type   = var.worker_image_type
    disk_size_gb = var.worker_disk_size_gb
  }
}

resource "google_compute_global_address" "frontend" {
  name    = "frontend-${var.environment}"
  project = var.project
}