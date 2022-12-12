
resource "azurerm_resource_group" "assignment1_resourcegrup" {
  name     = var.name
  location = var.location

tags     = {
   "costcenter" = "119" 
   "env"        = "assignment1"
 }
}

