resource "azurerm_network_interface" "app_vm" {
  name                = "vm-app-linux-dev-01843"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  accelerated_networking_enabled = true
  ip_forwarding_enabled          = false

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Manual"
    Project     = "AzureEnterpriseLab"
    Purpose     = "CloudEngineeringPortfolio"
    Workload    = "ApplicationCompute"
  }
}
