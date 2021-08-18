terraform {
  backend "azurerm" {
    resource_group_name  = "implementing_microservices"
    storage_account_name = "microservicessg"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.49.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Kubernetes Configuration
module "azure-kubernetes" {
  source = "github.com/RamVellanki/module-azure-kubernetes"
}


# Gitops Configuration
module "argo-cd-server" {
  source = "github.com/RamVellanki/module-argocd"

  kubernetes_cluster_endpoint = module.azure-kubernetes.kubernetes_cluster_endpoint
  client_certificate          = module.azure-kubernetes.client_certificate
  client_key                  = module.azure-kubernetes.client_key
  cluster_ca_certificate      = module.azure-kubernetes.cluster_ca_certificate
}
