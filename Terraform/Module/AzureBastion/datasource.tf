data "azurerm_subnet" "datasubnetbastion" {
    for_each = var.bastion-module-variable
  name                 = "AzureBastionSubnet"
  virtual_network_name = "frontendvnet"
  resource_group_name  = "14MayRG2024"
}

