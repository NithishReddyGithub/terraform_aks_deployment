resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}${random_string.acr_suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.acr_sku
  admin_enabled       = true
}

resource "random_string" "acr_suffix" {
  length  = 5
  upper   = false
  special = false
}