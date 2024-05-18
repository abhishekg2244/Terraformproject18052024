resource "azurerm_resource_group" "rgblock" {
    for_each = var.rg-module-variable
    name = lower (each.value.name)
    location = each.value.location
  
}