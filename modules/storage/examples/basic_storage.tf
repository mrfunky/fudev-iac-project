# examples/basic_storage.tf - Example usage of the storage module
module "storage" {
  source = "../"

  resource_group_name  = "<Your-storage-RG>"
  environment          = "dev"
  location             = "<Your_Region>"
  storage_account_name = "<Your_Storage_Name>"
  replication_type     = "LRS"
  # Optional configurations
  enable_https_only        = true
  min_tls_version          = "TLS1_2"
  allow_blob_public_access = false
}
