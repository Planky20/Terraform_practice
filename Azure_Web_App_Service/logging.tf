resource "azurerm_storage_account" "appstorewl8103" {
  name                     = "appstorewl8103"
  resource_group_name      = azurerm_resource_group.WLgroup.name
  location                 = local.resource_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "weblogswl" {
  name                  = "weblogswl"
  storage_account_id    = azurerm_storage_account.appstorewl8103.id
  container_access_type = "blob"
}

data "azurerm_storage_account_blob_container_sas" "accountsas" {
  connection_string = azurerm_storage_account.appstorewl8103.primary_connection_string
  container_name    = azurerm_storage_container.weblogswl.name
  https_only        = true

  start  = "2025-07-03"
  expiry = "2025-12-12"

  permissions {
    read   = true
    add    = true
    create = false
    write  = true
    delete = true
    list   = true
  }

}
