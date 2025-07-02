resource "azurerm_windows_web_app_slot" "webapp_slot" {
  name           = var.webapp_slot[1]                                         # The second element in the list is the slot name, e.g., "staging"
  app_service_id = azurerm_windows_web_app.webapp["${var.webapp_slot[0]}"].id # The first element in the list is the web app name, e.g., "webappvlad133795"

  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v8.0"
    }
  }
  depends_on = [azurerm_service_plan.serviceplan]
}
