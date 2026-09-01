resource "azurerm_bastion_host" "main" {
  name                = "vnet-enterprise-dev-bastion"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku = "Developer"

  scale_units        = 2
  virtual_network_id = azurerm_virtual_network.main.id
}
