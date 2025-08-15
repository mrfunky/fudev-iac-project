# examples/basic_compute.tf
module "compute" {
  source = "../"

  resource_group_name = "<YOUR_RESOURCE_GROUP_NAME>"
  environment         = "dev"
  location            = "<Your_Region>"

  vm_config = {
    name           = "example-vm"
    size           = "Standard_B2s"
    admin_username = "adminuser"

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
  }

  network_interface_id = module.networking.subnet_id
}
