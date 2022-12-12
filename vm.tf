

resource "azurerm_virtual_network" "terraformassignment1vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.assignment1_resourcegrup.location
  resource_group_name = azurerm_resource_group.assignment1_resourcegrup.name
}

resource "azurerm_subnet" "internal" {
  name                 = var.azurerm_subnet
  resource_group_name  = azurerm_resource_group.assignment1_resourcegrup.name
  virtual_network_name = azurerm_virtual_network.terraformassignment1vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "terraformassignment1inter" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.assignment1_resourcegrup.location
  resource_group_name = azurerm_resource_group.assignment1_resourcegrup.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "terraformassignment1vmachine" {
  name                  = var.virtual_machine_name
  location              = azurerm_resource_group.assignment1_resourcegrup.location
  resource_group_name   = azurerm_resource_group.assignment1_resourcegrup.name
  network_interface_ids = [azurerm_network_interface.terraformassignment1inter.id]
  vm_size               = "Standard_DS1_v2"


  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}