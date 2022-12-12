
resource "azurerm_storage_account" "terraformassingment1sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.assignment1_resourcegrup.name
  location                 = azurerm_resource_group.assignment1_resourcegrup.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    env = "aliassignment"
  }
}
