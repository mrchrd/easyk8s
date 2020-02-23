resource "azurerm_resource_group" "main" {
  location = local.azure_location
  name     = local.cluster_name
}

output "resource_group" {
  value = azurerm_resource_group.main.name
}
