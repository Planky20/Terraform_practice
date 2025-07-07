resource "azurerm_service_plan" "serviceplan" {
  for_each            = var.app_environment.production.serviceplan
  name                = each.key
  resource_group_name = azurerm_resource_group.WLgroup.name
  location            = local.resource_location
  os_type             = each.value.os_type
  sku_name            = each.value.sku
}

resource "azurerm_windows_web_app" "webapp" {
  for_each            = var.app_environment.production.serviceapp
  name                = each.key
  resource_group_name = azurerm_resource_group.WLgroup.name
  location            = local.resource_location

  service_plan_id = azurerm_service_plan.serviceplan[each.value].id

  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v8.0"
    }
  }

  connection_string {
    name  = "MySQLConnectionString"                                               # Name of the connection string
    type  = "Custom"                                                              # Because we are using to own MySQL database hosten on Ubuntu VM
    value = "Server=10.0.1.4;UserID=appusr;Password=Microsoft@123;Database=appdb" # This is the connection string to the MySQL database
  }

}


resource "azurerm_app_service_source_control" "appservice_sourcecontrol" {   # This resource is used to configure the source control for the web app
  app_id                 = azurerm_windows_web_app.webapp["webapp0707wl"].id # The ID of the web app to which the source control is being applied
  repo_url               = "https://github.com/Planky20/mysqlwebapp0707"     # The URL of the GitHub repository containing the web app code
  branch                 = "main"
  use_manual_integration = true
}

resource "azurerm_app_service_virtual_network_swift_connection" "websubnet_webapp" { # This resource is used to connect the web app to a virtual network where the database is hosted
  app_service_id = azurerm_windows_web_app.webapp["webapp0707wl"].id # The ID of the web app to which the VNet connection is being applied
  subnet_id      = azurerm_subnet.appsubnet01.id                     # The ID of the subnet in the virtual network to which the web app will connect
  depends_on = [azurerm_subnet.appsubnet01,
  azurerm_windows_web_app.webapp]
}

