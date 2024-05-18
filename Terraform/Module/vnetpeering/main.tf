
resource "azurerm_virtual_network_peering" "peer1topeer2" {
  name                      = "peer1to2"
  resource_group_name       = "14MayRG2024"
  virtual_network_name      = data.azurerm_virtual_network.datavnet1block.name
  remote_virtual_network_id = data.azurerm_virtual_network.datavnet2block.id
}

resource "azurerm_virtual_network_peering" "peer2topeer1" {
  name                      = "peer2to1"
  resource_group_name       = "14MayRG2024"
  virtual_network_name      = data.azurerm_virtual_network.datavnet2block.name
  remote_virtual_network_id =data.azurerm_virtual_network.datavnet1block.id
}

data "azurerm_virtual_network" "datavnet1block" {
  name                = "frontendvnet"
  resource_group_name = "14MayRG2024"
}

data "azurerm_virtual_network" "datavnet2block" {
  name                = "backendvnet"
  resource_group_name = "14MayRG2024"
}

