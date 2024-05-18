module "rgmodule" {
   source = "../../Module/ResourceGroup" 
    rg-module-variable = var.rgvariable
}

module "vnetmodule" {
    depends_on = [ module.rgmodule ]
 source = "../../Module/VirtualNetwork" 
 vnet-module-variable = var.vnetvariable
}

module "subnetmodule" {
    depends_on = [ module.rgmodule ,module.vnetmodule]
    source = "../../Module/Subnet"
   subnet-module-variable = var.subnetvariable
}

module "vmmodule" {
    depends_on = [  module.rgmodule,module.vnetmodule,module.subnetmodule]
    source = "../../Module/VirtualMachine"
    vm-module-variable = var.linuxvmvariable
  
}

module "lbmodule" {
    depends_on = [ module.rgmodule,module.vmmodule, module.vnetmodule]
    source = "../../Module/AzureLoadbalancer"
    lb-module-variable = var.lbvariable
  
}

module "bastionmodule" {
  depends_on = [ module.rgmodule , module.subnetmodule,module.vnetmodule ]
  source = "../../Module/AzureBastion"
  bastion-module-variable = var.bastionvariable
}

module "peermodule" {
    depends_on = [ module.rgmodule,module.vnetmodule ]
source = "../../Module/vnetpeering"
vnetpeer-module-variable = var.vnetpeervariable
}