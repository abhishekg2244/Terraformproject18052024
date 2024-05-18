resource "azurerm_public_ip" "lbpublicipblock" {
    for_each = var.lb-module-variable
  name                = each.value.pip-name
  location            =each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku = "Standard"
}

resource "azurerm_lb" "lbblock" {
    for_each = var.lb-module-variable
  name                = each.value.lbname
  location            =each.value.location
  resource_group_name = each.value.resource_group_name
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "lbfip"
    public_ip_address_id = azurerm_public_ip.lbpublicipblock[each.key].id
  }
}

resource "azurerm_lb_backend_address_pool" "backendpoolblock" {
    for_each = var.lb-module-variable
  loadbalancer_id = azurerm_lb.lbblock[each.key].id
  name            = each.value.backendpoolname
}


resource "azurerm_lb_probe" "probeblock" {
    for_each = var.lb-module-variable
  loadbalancer_id = azurerm_lb.lbblock[each.key].id
  name            = each.value.probename
  port            = 22
}

resource "azurerm_lb_rule" "lbruleblock" {
    for_each = var.lb-module-variable
  loadbalancer_id                = azurerm_lb.lbblock[each.key].id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "lbfip"
  probe_id = azurerm_lb_probe.probeblock[each.key].id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backendpoolblock[each.key].id]
}

resource "azurerm_lb_backend_address_pool_address" "addpool1" {
    for_each = var.lb-module-variable
  name                    = "Appvm1"
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.databackendaddresspool[each.key].id
  virtual_network_id      = data.azurerm_virtual_network.datablockvnet[each.key].id
  ip_address              = "10.1.1.5"

}
resource "azurerm_lb_backend_address_pool_address" "addpool2" {
    for_each = var.lb-module-variable
  name                    = "appvm2"
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.databackendaddresspool[each.key].id
  virtual_network_id      = data.azurerm_virtual_network.datablockvnet[each.key].id
  ip_address              = "10.1.1.4"
}
data "azurerm_virtual_network" "datablockvnet" {
    for_each = var.lb-module-variable
  name                = "frontendvnet"
  resource_group_name = "14MayRG2024"

}

data "azurerm_lb_backend_address_pool" "databackendaddresspool" {
    for_each = var.lb-module-variable
  name            = azurerm_lb_backend_address_pool.backendpoolblock[each.key].name
  loadbalancer_id = azurerm_lb.lbblock[each.key].id
}


data "azurerm_virtual_network" "example" {
  name                = "frontendvnet"
  resource_group_name = "14MayRG2024"
}