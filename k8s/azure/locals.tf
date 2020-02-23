resource "random_pet" "cluster" {
  separator = ""
}

locals {
  azure_location  = var.azure_location
  cluster_name    = coalesce(var.cluster_name, random_pet.cluster.id)
  cluster_version = var.cluster_version
  vm_size         = var.vm_size
}
