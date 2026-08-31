resource "azurerm_data_protection_backup_vault" "main" {
  name                = "bv-azure-enterprise-dev"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  datastore_type = "VaultStore"
  redundancy     = "LocallyRedundant"

  identity {
    type = "SystemAssigned"
  }

  soft_delete = "On"

  tags = {
    Environment = "Development"
    ManagedBy   = "Manual"
    Project     = "AzureEnterpriseLab"
    Purpose     = "CloudEngineeringPortfolio"
  }
}

resource "azurerm_recovery_services_vault" "main" {
  name                = "rsv-enterprise-dev-uks"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "RS0"

  storage_mode_type = "GeoRedundant"

}
