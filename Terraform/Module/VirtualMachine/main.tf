resource "azurerm_network_interface" "nicblock" {
    for_each = var.vm-module-variable
    name = each.value.nic-name
    location = each.value.location
    resource_group_name = each.value.resource_group_name

    ip_configuration {
      name = "internal"
      subnet_id = data.azurerm_subnet.subnetdatablock[each.key].id
      private_ip_address_allocation = "Dynamic"
    }
  
}

resource "azurerm_linux_virtual_machine" "vmblock" {
  for_each = var.vm-module-variable
  name                = each.value.vmname
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password = "Qwertyuiop@1234"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nicblock[each.key].id,
  ]

  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}