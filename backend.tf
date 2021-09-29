terraform {
  backend "azurerm" {
    resource_group_name  = "UTILS"
    storage_account_name = "greyshoretfstate"
  }
}