terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-westeurope"
    storage_account_name = "csb2b81130f4125x4cf8xb71"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

# Network configuration

# EKS Configuration

# Gitops Configuration
