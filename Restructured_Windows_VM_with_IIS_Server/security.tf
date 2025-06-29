# First assign KV admin role to the Terraform service principal

resource "azurerm_key_vault" "appvaultplanky20" {
  name                          = "appvaultplanky20"
  location                      = local.resource_location
  resource_group_name           = azurerm_resource_group.appgrp.name
  enabled_for_disk_encryption   = true
  public_network_access_enabled = true
  enable_rbac_authorization     = true
  tenant_id                     = "14cb4ab4-62b8-45a2-a944-e225383ee1f9"
  soft_delete_retention_days    = 7
  purge_protection_enabled      = false
  sku_name                      = "standard"
}

resource "azurerm_key_vault_secret" "vmpassword" {
  name         = "vmpassword"
  value        = var.adminpassword
  key_vault_id = azurerm_key_vault.appvaultplanky20.id
}