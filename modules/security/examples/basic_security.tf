# examples/basic_security.tf
module "security" {
  source = "../"

  resource_group_name = "<YOUR_RESOURCE_GROUP_NAME>"
  environment         = "dev"
  location            = "eastus"
  key_vault_name      = "<YOUR_KEYVAULT_NAME>" # Must be globally unique and match Azure naming rules
}
