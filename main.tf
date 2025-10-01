# Main Terraform configuration for IAC-BC project

# Random ID for unique naming
resource "random_id" "suffix" {
  byte_length = 4
}

# Create the main resource group
resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location

  tags = local.common_tags
}

# Create the main storage account
resource "azurerm_storage_account" "main" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type

  # Enable blob versioning and soft delete
  blob_properties {
    versioning_enabled = true
    
    delete_retention_policy {
      days = 7
    }
  }

  tags = merge(local.common_tags, {
    Name = "Main Storage Account"
    Type = "Storage"
  })
}

# Create a storage container for general use
resource "azurerm_storage_container" "main" {
  name                 = "general"
  storage_account_id   = azurerm_storage_account.main.id
  container_access_type = "private"
}