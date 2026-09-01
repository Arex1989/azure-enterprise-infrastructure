resource "azurerm_storage_account" "main" {
  name                     = "stazureenterprisedev"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  min_tls_version                   = "TLS1_2"
  https_traffic_only_enabled        = true
  allow_nested_items_to_be_public   = false
  shared_access_key_enabled         = true
  default_to_oauth_authentication   = true
  cross_tenant_replication_enabled  = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 35
    }

    container_delete_retention_policy {
      days = 7
    }

    change_feed_enabled           = true
    change_feed_retention_in_days = 35

    restore_policy {
      days = 30
    }
  }

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]

    ip_rules = [
      "61.8.130.19"
    ]

    virtual_network_subnet_ids = [
      azurerm_subnet.app.id
    ]
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Manual"
    Project     = "AzureEnterpriseLab"
    Purpose     = "CloudEngineeringPortfolio"
  }
}

resource "azurerm_storage_account" "recovery" {
  name                     = "stazurerecoverydev"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  default_to_oauth_authentication = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true
  public_network_access_enabled   = true

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = ["84.163.215.44"]
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Manual"
    Project     = "AzureEnterpriseLab"
    Purpose     = "CloudEngineeringPortfolio"
  }
}
