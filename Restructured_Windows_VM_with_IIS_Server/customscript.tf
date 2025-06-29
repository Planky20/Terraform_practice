resource "azurerm_storage_account" "appstorevlad13" {
  name                     = "appstorevlad13"
  resource_group_name      = azurerm_resource_group.appgrp.name
  location                 = local.resource_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

}

resource "azurerm_storage_container" "scripts" {
  name                  = "scripts"
  storage_account_id  = azurerm_storage_account.appstorevlad13.id
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "IISconfig" {
  name                   = "IIS.ps1"
  storage_account_name   = azurerm_storage_account.appstorevlad13.name
  storage_container_name = azurerm_storage_container.scripts.name
  type                   = "Block"
  source                 = "IIS.ps1"
}

resource "azurerm_virtual_machine_extension" "vmextension" {
  name                 = "vmextension"
  virtual_machine_id   = azurerm_windows_virtual_machine.webvm["webvm01"].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
      "fileUris": [
        "https://${azurerm_storage_account.appstorevlad13.name}.blob.core.windows.net/${azurerm_storage_container.scripts.name}/${azurerm_storage_blob.IISconfig.source}"
      ],
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ${azurerm_storage_blob.IISconfig.source}"
    }
SETTINGS
}