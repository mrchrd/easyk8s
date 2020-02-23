resource "google_container_cluster" "main" {
  depends_on = [google_project_service.cloudresourcemanager, google_project_service.container]

  initial_node_count       = 1
  location                 = local.gcp_region
  min_master_version       = local.cluster_version
  name                     = local.cluster_name
  remove_default_node_pool = true
}

output "cluster_name" {
  value = google_container_cluster.main.name
}

output "location" {
  value = google_container_cluster.main.location
}

output "project" {
  value = google_container_cluster.main.project
}
