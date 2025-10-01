# Local values for computed configurations

locals {
  # Generate resource group name if not provided
  resource_group_name = var.resource_group_name != null ? var.resource_group_name : "rg-${var.project_name}-${var.environment}-${random_id.suffix.hex}"
  
  # Generate storage account name (must be globally unique and lowercase)
  storage_account_name = "st${var.project_name}${var.environment}${random_id.suffix.hex}"
  
  # Common tags to be applied to all resources
  common_tags = merge(var.tags, {
    Environment = var.environment
    Location    = var.location
    CreatedBy   = "Terraform"
    CreatedDate = formatdate("YYYY-MM-DD", timestamp())
  })
  
  # Resource naming convention
  naming_convention = {
    resource_group    = "rg-${var.project_name}-${var.environment}"
    storage_account   = "st${var.project_name}${var.environment}"
    key_vault        = "kv-${var.project_name}-${var.environment}"
    app_service_plan = "asp-${var.project_name}-${var.environment}"
    web_app          = "app-${var.project_name}-${var.environment}"
  }
}