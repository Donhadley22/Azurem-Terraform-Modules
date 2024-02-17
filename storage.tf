resource "azurerm_resource_group" "hcl-rg" {
  name     = "hcl-rg-resources"
  location = "East US"
}

resource "azurerm_virtual_network" "hcl-vnet" {
  name                = "hcl-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hcl-rg.location
  resource_group_name = azurerm_resource_group.hcl-rg.name
}

resource "azurerm_subnet" "hcl-sub" {
  name                 = "hcl-subnet"
  resource_group_name  = azurerm_resource_group.hcl-rg.name
  virtual_network_name = azurerm_virtual_network.hcl-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_storage_account" "hcl-strg" {
  name                = "hclstorage2420"
  resource_group_name = azurerm_resource_group.hcl-rg.name
  location                 = azurerm_resource_group.hcl-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.hcl-sub.id]
  }

  tags = {
    environment = "staging"
  }
}