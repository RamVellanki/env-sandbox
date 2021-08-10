terraform {
  backend "azurerm" {
    resource_group_name  = "implementing_microservices"
    storage_account_name = "microservicessg"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

# Network configuration

# EKS Configuration

# Gitops Configuration
