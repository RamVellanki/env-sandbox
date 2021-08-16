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

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "learnk8scluster"
  dns_prefix          = "learnk8scluster"
  resource_group_name = "implementing_microservices"
  location            = "southindia"

  default_node_pool {
    name       = "default"
    node_count = "2"
    vm_size    = "standard_d2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Network configuration

# EKS Configuration

# Gitops Configuration
module "argo-cd-server" {
  source = "github.com/RamVellanki/module-argocd"

  kubernetes_cluster_endpoint = kubernetes_cluster_endpoint
  client_certificate     = client_certificate
  client_key             = client_key
  cluster_ca_certificate = cluster_ca_certificate
}
