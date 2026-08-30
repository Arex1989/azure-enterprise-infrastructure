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


resource "azurerm_monitor_action_group" "main" {
  name                = "ag-azure-enterprise-dev"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "AzureEntDev"
  enabled             = true

  email_receiver {
    name                    = "Email-CloudOps_-EmailAction-"
    email_address           = "rexmond.anih@yahoo.com"
    use_common_alert_schema = false
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Manual"
    Project     = "AzureEnterpriseLab"
    Purpose     = "CloudEngineeringPortfolio"
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "blob_failures" {
  name                = "alert-blob-failures-dev"
  display_name        = "alert-blob-failures-dev"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  scopes = [
    lower(azurerm_log_analytics_workspace.main.id)
  ]

  target_resource_types = [
    "microsoft.operationalinsights/workspaces"
  ]

  description = "Detects failed Azure Blob Storage operations recorded in Log Analytics and triggers when one or more HTTP 4xx/5xx responses occur within the configured evaluation period."

  enabled                 = true
  severity                = 2
  evaluation_frequency    = "PT30M"
  window_duration         = "PT30M"
  auto_mitigation_enabled = true
  skip_query_validation   = false


  criteria {
    query = <<-QUERY
    StorageBlobLogs
    | where OperationName in (
        "GetBlob",
        "PutBlob",
        "DeleteBlob",
        "ListBlobs"
    )
    | where toint(StatusCode) == 401
        or toint(StatusCode) == 403
        or toint(StatusCode) >= 500
    | where Uri !contains "$blobchangefeed"
  QUERY

    operator                = "GreaterThan"
    threshold               = 0
    time_aggregation_method = "Count"
    resource_id_column      = "_ResourceId"

    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [
      replace(
        azurerm_monitor_action_group.main.id,
        "Microsoft.Insights",
        "microsoft.insights"
      )
    ]

    email_subject     = "AzureEnterpriseLab - Blob Storage Failure Alert"
    custom_properties = {}
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Manual"
    Project     = "AzureEnterpriseLab"
    Purpose     = "CloudEngineeringPortfolio"
  }

  lifecycle {
    ignore_changes = [
      action[0].action_groups
    ]
  }
}
