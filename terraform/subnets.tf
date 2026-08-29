resource "azurerm_subnet" "web" {
  name                            = "snet-web"
  resource_group_name             = azurerm_resource_group.main.name
  virtual_network_name            = azurerm_virtual_network.main.name
  address_prefixes                = ["10.10.1.0/24"]
  default_outbound_access_enabled = false
}

resource "azurerm_subnet" "app" {
  name                            = "snet-app"
  resource_group_name             = azurerm_resource_group.main.name
  virtual_network_name            = azurerm_virtual_network.main.name
  address_prefixes                = ["10.10.2.0/24"]
  default_outbound_access_enabled = false

  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "management" {
  name                            = "snet-management"
  resource_group_name             = azurerm_resource_group.main.name
  virtual_network_name            = azurerm_virtual_network.main.name
  address_prefixes                = ["10.10.3.0/24"]
  default_outbound_access_enabled = false
}
