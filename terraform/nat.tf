resource "azurerm_public_ip" "nat" {
  name                = "pip-nat-app-dev"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  allocation_method = "Static"
  sku               = "Standard"
  sku_tier          = "Regional"
  ip_version        = "IPv4"
}

resource "azurerm_nat_gateway" "app" {
  name                    = "nat-app-dev"
  location                = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4

  tags = {
    Environment = "Development"
    ManagedBy   = "Manual"
    Project     = "AzureEnterpriseLab"
    Purpose     = "CloudEngineeringPortfolio"
    Workload    = "ApplicationCompute"
  }
}

resource "azurerm_nat_gateway_public_ip_association" "app" {
  nat_gateway_id       = azurerm_nat_gateway.app.id
  public_ip_address_id = azurerm_public_ip.nat.id
}
