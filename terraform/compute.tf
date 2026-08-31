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


resource "azurerm_linux_virtual_machine" "app_vm" {
  name                = "vm-app-linux-dev-01"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B2ls_v2"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.app_vm.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICKV+ga510CrMaH1d0DuVQj7HJZ81w3Z6OkVzX8wQhMZ generated-by-azure"
  }

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  additional_capabilities {
    hibernation_enabled = false
    ultra_ssd_enabled   = false
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  secure_boot_enabled = true
  vtpm_enabled        = true

  boot_diagnostics {}

  patch_assessment_mode = "AutomaticByPlatform"
  patch_mode            = "ImageDefault"

  tags = {
    Environment = "Development"
    ManagedBy   = "Manual"
    Project     = "AzureEnterpriseLab"
    Purpose     = "CloudEngineeringPortfolio"
    Workload    = "ApplicationCompute"
  }
  lifecycle {
    ignore_changes = [
      admin_ssh_key,
      source_image_reference
    ]
  }

}

