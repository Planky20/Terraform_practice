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
  for_each             = { for detail in local.database_details : detail.database_name => detail }
  name                 = each.key
  server_id            = azurerm_mssql_server.wlsqlserver["${each.value.server_name}"].id
  collation            = "SQL_Latin1_General_CP1_CI_AS"
  license_type         = "LicenseIncluded"
  max_size_gb          = 2
  sku_name             = each.value.database_sku
  sample_name          = each.value.database_sampledb
  storage_account_type = "Local"

}

resource "azurerm_mssql_firewall_rule" "allowmyclient" {
  for_each         = var.dbapp_environment.production.server
  name             = "AllowClientIP"
  server_id        = azurerm_mssql_server.wlsqlserver["${each.key}"].id
  start_ip_address = "176.221.108.142"
  end_ip_address   = "176.221.108.142"
}

resource "null_resource" "database_setup" {
  provisioner "local-exec" {
    command = "sqlcmd -S ${azurerm_mssql_server.wlsqlserver["${var.app_setup[0]}"].fully_qualified_domain_name} -U ${azurerm_mssql_server.wlsqlserver["${var.app_setup[0]}"].administrator_login} -P ${azurerm_mssql_server.wlsqlserver["${var.app_setup[0]}"].administrator_login_password} -d ${var.app_setup[1]} -i 01.sql" # This is a utility that allows to execute SQL commands againts Microsoft SQL Server databases
  }
  depends_on = [azurerm_mssql_database.wlsqldb]
}
