resource "google_container_node_pool" "main" {
  cluster    = google_container_cluster.main.name
  location   = google_container_cluster.main.location
  node_count = 1

  node_config {
    machine_type = local.machine_type
  }
}
