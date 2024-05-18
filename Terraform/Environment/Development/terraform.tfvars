rgvariable = {
  rg1 ={
    name ="14MayRG2024"
    location = "west europe"
  }
}

vnetvariable = {
  vnet1 ={
     name ="frontendvnet"
    resource_group_name = "14MayRG2024"
    location = "west europe"
    address_space = ["10.1.0.0/16"]
  }

  vnet2 ={
     name ="backendvnet"
    resource_group_name = "14MayRG2024"
    location = "west europe"
    address_space = ["10.2.0.0/16"]
  }
}

subnetvariable = {
  subnet1 = {
  name                 = "forntendsubnet"
  resource_group_name  = "14MayRG2024"
  virtual_network_name = "frontendvnet"
  address_prefixes     = ["10.1.1.0/24"]
  }

  Subnet2 = {
    name               = "backendsubnet"
  resource_group_name  = "14MayRG2024"
  virtual_network_name = "backendvnet"
  address_prefixes     = ["10.2.1.0/24"]
  }

 subnet3 ={
  name                 = "AzureBastionSubnet"
  resource_group_name  = "14MayRG2024"
  virtual_network_name = "frontendvnet"
  address_prefixes     = ["10.1.100.0/24"]

}
}

linuxvmvariable = {
  linuxvm1 = {
    vmname = "frontendvm1"
    nic-name = "frontendvm1-nic"
    location = "west europe"
    resource_group_name = "14MayRG2024"
    subnetdata = "forntendsubnet"
    virtual_network_name = "frontendvnet"
  }

  linuxvm2 = {
    vmname = "frontendvm2"
    nic-name = "frontendvm2-nic"
    location = "west europe"
    resource_group_name = "14MayRG2024"
    subnetdata = "forntendsubnet"
    virtual_network_name = "frontendvnet"
  }
}

lbvariable = {
  lbdetails ={
  pip-name                = "PublicIPForLB"
  location            ="west europe"
  resource_group_name = "14MayRG2024"
  allocation_method   = "Static"
  lbname      = "ApplicationLoadBalancer"
  backendpoolname = "BackEndAddressPool"
  probename = "healthprobe"
  }
}

bastionvariable = {
  bastiondetails ={
    bastion-pip-name = "bastionpublicip"
    resource_group_name = "14MayRG2024"
    location            ="west europe"
  }
}

#provided value Hardcoded in Main.tf
vnetpeervariable ={
  peerdetails ={

  }
}

