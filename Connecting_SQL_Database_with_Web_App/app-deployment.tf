resource "azurerm_service_plan" "serviceplan" {
  for_each            = var.webapp_environment.production.serviceplan
  name                = each.key
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.WLgroup.name
  sku_name            = each.value.sku
  os_type             = each.value.os_type
}

resource "azurerm_windows_web_app" "webapp" {
  for_each            = var.webapp_environment.production.serviceapp
  name                = each.key
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.WLgroup.name

  service_plan_id = azurerm_service_plan.serviceplan[each.value].id

  site_config {
    always_on = false
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v8.0"
    }
  }

  connection_string {
    name  = "AZURE_SQL_CONNECTIONSTRING" # The web-app .net code uses this connection string to connect to the SQL database
    type  = "SQLAzure"
    value = "Data source = tcp:${azurerm_mssql_server.wlsqlserver["${var.app_setup[0]}"].fully_qualified_domain_name},1433;Initial catalog = ${var.app_setup[1]};User ID = ${azurerm_mssql_server.wlsqlserver["${var.app_setup[0]}"].administrator_login};Password = ${azurerm_mssql_server.wlsqlserver["${var.app_setup[0]}"].administrator_login_password}';"
  }
}

resource "azurerm_mssql_firewall_rule" "allowservices" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.wlsqlserver["${var.app_setup[0]}"].id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_app_service_source_control" "appservice_sourcecontrol" {
  app_id                 = azurerm_windows_web_app.webapp["webappwl0607"].id
  repo_url               = "Github repo containing the web app code URL"
  branch                 = "main"
  use_manual_integration = true
}
