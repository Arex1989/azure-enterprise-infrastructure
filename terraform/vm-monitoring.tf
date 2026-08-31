resource "azurerm_virtual_machine_extension" "azure_monitor_linux_agent" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.app_vm.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
}

resource "azurerm_monitor_data_collection_rule" "vm_metrics" {
  name                = "msvmi-uksouth-vm-app-linux-dev-01"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  data_flow {
    streams      = ["Microsoft-OtelPerfMetrics"]
    destinations = ["MonitoringAccountDestination"]
  }

  data_sources {
  }

  destinations {
    monitor_account {
      name               = "MonitoringAccountDestination"
      monitor_account_id = "/subscriptions/2f877566-9b2a-464f-bf1b-722384e7c844/resourcegroups/defaultresourcegroup-suk/providers/microsoft.monitor/accounts/defaultazuremonitorworkspace-suk"
    }
  }
}
