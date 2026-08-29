resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-azure-enterprise-dev"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku               = "PerGB2018"
  retention_in_days = 31
  daily_quota_gb    = 0.1

  local_authentication_enabled    = false
  internet_ingestion_enabled      = true
  internet_query_enabled          = true
  allow_resource_only_permissions = true

  tags = {
    Environment = "Development"
    ManagedBy   = "Manual"
    Project     = "AzureEnterpriseLab"
    Purpose     = "CloudEngineeringPortfolio"
  }
}
