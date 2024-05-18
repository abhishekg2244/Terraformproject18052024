

resource "azurerm_public_ip" "publicIpblockbastion" {
    for_each = var.bastion-module-variable
  name                = each.value.bastion-pip-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_bastion_host" "bastionhost" {
     for_each = var.bastion-module-variable
  name                = "jumpbox"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.datasubnetbastion[each.key].id
    public_ip_address_id = azurerm_public_ip.publicIpblockbastion[each.key].id
  }
}