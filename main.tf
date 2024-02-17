# Create a resource group
resource "azurerm_resource_group" "hcl2" {
  name     = "hcl2-resources"
  location = "east us"
}

# Create a virtual network
resource "azurerm_virtual_network" "hcl2-vnet" {
  name                = "hcl2-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hcl2.location
  resource_group_name = azurerm_resource_group.hcl2.name
}

# Create a subnet
resource "azurerm_subnet" "hcl2-sub" {
  name                 = "hcl2-sub"
  resource_group_name  = azurerm_resource_group.hcl2.name
  virtual_network_name = azurerm_virtual_network.hcl2-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a network interface with a public IP address
resource "azurerm_network_interface" "hcl2-int" {
  name                = "hcl2-nic"
  location            = azurerm_resource_group.hcl2.location
  resource_group_name = azurerm_resource_group.hcl2.name

  ip_configuration {
    name                          = "hcl2-ip"
    subnet_id                     = azurerm_subnet.hcl2-sub.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a virtual machine with a network interface attached
resource "azurerm_virtual_machine" "hcl2-vm" {
  name                  = "hcl2-vm"
  location              = azurerm_resource_group.hcl2.location
  resource_group_name   = azurerm_resource_group.hcl2.name
  vm_size               = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.hcl2-int.id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "hcl2-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "azureuser"
    admin_password = "hagital12345#"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}