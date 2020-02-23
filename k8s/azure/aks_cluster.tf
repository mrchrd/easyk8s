resource "azurerm_kubernetes_cluster" "main" {
  dns_prefix          = local.cluster_name
  kubernetes_version  = local.cluster_version
  location            = azurerm_resource_group.main.location
  name                = local.cluster_name
  resource_group_name = azurerm_resource_group.main.name

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = local.vm_size
  }

  service_principal {
    client_id     = azuread_service_principal.main.application_id
    client_secret = azuread_service_principal_password.main.value
  }
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}
