resource "random_pet" "cluster" {
  separator = ""
}

locals {
  cluster_name    = coalesce(var.cluster_name, random_pet.cluster.id)
  cluster_version = var.cluster_version
  gcp_region      = var.gcp_region
  machine_type    = var.machine_type
}
