# Variables for the Terraform configuration

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "Canada Central"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "iac-bc"
}

variable "resource_group_name" {
  description = "Name of the resource group (optional - will be generated if not provided)"
  type        = string
  default     = null
}

variable "storage_account_tier" {
  description = "Storage account performance tier"
  type        = string
  default     = "Standard"
  
  validation {
    condition     = contains(["Standard", "Premium"], var.storage_account_tier)
    error_message = "Storage account tier must be either Standard or Premium."
  }
}

variable "storage_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
  
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS"], var.storage_replication_type)
    error_message = "Storage replication type must be one of: LRS, GRS, RAGRS, ZRS."
  }
}

variable "tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "IAC-BC"
  }
}