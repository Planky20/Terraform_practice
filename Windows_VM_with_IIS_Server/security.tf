data "azurerm_key_vault" "appvault13379507" {
  name                = "appvault13379507"
  resource_group_name = "app-grp"
}

resource "azurerm_key_vault_secret" "vmpassword" {
  name         = "vmpassword"
  value        = var.adminpassword
  key_vault_id = data.azurerm_key_vault.appvault13379507.id
}