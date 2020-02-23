data "azurerm_subscription" "current" {}

resource "random_password" "service_principal" {
  length  = 32
  special = true
}

resource "azuread_application" "main" {
  name = local.cluster_name
}

resource "azuread_service_principal" "main" {
  application_id = azuread_application.main.application_id
}

resource "azuread_service_principal_password" "main" {
  end_date_relative    = "8760h" # 1yr
  service_principal_id = azuread_service_principal.main.id
  value                = random_password.service_principal.result
}

resource "azurerm_role_assignment" "main" {
  principal_id         = azuread_service_principal.main.id
  role_definition_name = "Contributor"
  scope                = data.azurerm_subscription.current.id
}
