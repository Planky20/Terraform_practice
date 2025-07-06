resource "azurerm_resource_group" "WLgroup" {
  name     = "WLgroup"
  location = local.resource_location
}

resource "azurerm_mssql_server" "wlsqlserver" {
  for_each                     = var.dbapp_environment.production.server
  name                         = each.key
  resource_group_name          = azurerm_resource_group.WLgroup.name
  location                     = local.resource_location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Azure@777"

}


resource "azurerm_mssql_database" "wlsqldb" {
  for_each     = var.dbapp_environment.production.server
  name         = each.value.dbname
  server_id    = azurerm_mssql_server.wlsqlserver[each.key].id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = each.value.sku
  storage_account_type = "Local"

}
