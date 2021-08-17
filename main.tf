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

# Gitops Configuration
module "argo-cd-server" {
  source = "github.com/RamVellanki/module-argocd"

  kubernetes_cluster_endpoint = azurerm_kubernetes_cluster.cluster.kube_config.0.host
  client_certificate     = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
  client_key             = azurerm_kubernetes_cluster.cluster.kube_config.0.client_key
  cluster_ca_certificate = azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate
}
