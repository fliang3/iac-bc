# Configure Terraform and required providers
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
  
  # Uncomment and configure for remote state storage
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-state"
  #   storage_account_name = "tfstate"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }
}

# Configure the Azure Provider
provider "azurerm" {
  features {
    # Enable soft delete for key vaults
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
    
    # Configure resource group behavior
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}