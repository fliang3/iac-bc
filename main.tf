# Configure the required providers
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Define variables
variable "location" {
  description = "Azure region"
  type        = string
  default     = "West US"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-${var.environment}-${random_id.suffix.hex}"
  location = var.location

  tags = {
    Environment = var.environment
  }
}

# Example resource - Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "st${var.environment}${random_id.suffix.hex}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Name        = "Example Storage Account"
    Environment = var.environment
  }
}

# Random ID for unique naming
resource "random_id" "suffix" {
  byte_length = 4
}

# Output the storage account name
output "storage_account_name" {
  description = "Name of the Azure Storage Account"
  value       = azurerm_storage_account.example.name
}

# Output the resource group name
output "resource_group_name" {
  description = "Name of the Azure Resource Group"
  value       = azurerm_resource_group.example.name
}