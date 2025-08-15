# commit 12f4e56: Defined Azure provider requirements
# Configured the required AzureRM provider to ensure compatibility with our project.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# commit 34a1b56: Initial storage resource group setup
# Created a resource group for organizing storage resources based on the environment.

resource "azurerm_resource_group" "storage" {
  name     = "${var.environment}-${var.resource_group_name}"
  location = var.location

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# commit 89c4d23: Enhanced storage account configuration
# Added storage account resource with security configurations, including network rules and blob properties.

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.storage.name
  location                 = azurerm_resource_group.storage.location
  account_tier             = "Standard"
  account_replication_type = var.replication_type
  min_tls_version          = "TLS1_2"

  network_rules {
    default_action = var.network_rules.default_action
    ip_rules       = var.network_rules.ip_rules
    bypass         = var.network_rules.bypass
  }

  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "Application Storage"
  }
}

# commit abc123d: Added default storage container
# Introduced a private storage container to serve as the default for application use.

resource "azurerm_storage_container" "default" {
  name                  = "default"
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}
