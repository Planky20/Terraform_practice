resource "azurerm_resource_group" "WLgroup" {
  name     = "WLgroup"
  location = local.resource_location
}