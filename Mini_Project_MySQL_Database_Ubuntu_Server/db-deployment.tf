resource "azurerm_network_interface" "dbinterfaces" {
  for_each            = var.app_environment.production.subnets["dbsubnet01"].machines
  name                = each.value.networkinterfacename
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.WLgroup.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app_network_subnets["dbsubnet01"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dbip[each.key].id
  }
}

resource "azurerm_public_ip" "dbip" {
  for_each            = var.app_environment.production.subnets["dbsubnet01"].machines
  name                = each.value.publicipaddressname
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.WLgroup.name
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "dbvm" {
  for_each                        = var.app_environment.production.subnets["dbsubnet01"].machines
  name                            = each.key
  resource_group_name             = azurerm_resource_group.WLgroup.name
  location                        = local.resource_location
  size                            = "Standard_B1s"
  admin_username                  = "linuxadmin"
  admin_password                  = var.adminpassword
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.dbinterfaces[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}