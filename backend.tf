terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatelocking"
    container_name       = "tfstate"
    key                  = "aks/terraform.tfstate"
    use_azuread_auth     = true
  }
}