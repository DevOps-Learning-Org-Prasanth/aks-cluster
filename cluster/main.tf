terraform {
  backend "azurerm" {
    resource_group_name  = "Cloud-DevOps-Training"
    storage_account_name = "cloudconfigbackend"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.26"
    }
  }
}

provider "azurerm" {
  features {}
}
resource "azurerm_user_assigned_identity" "aks" {
  resource_group_name = "Cloud-DevOps-Training"
  location            = "southcentralus"
  name                = "test-managedIdentity"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "ContainerTraining"
  resource_group_name = "Cloud-DevOps-Training"
  location            = "southcentralus"
  dns_prefix          = "ContainerTraining-dns"
  kubernetes_version  = "1.26.3"
  oidc_issuer_enabled = true
  workload_identity_enabled = true
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS3_v2"
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks.id]
  }
}

data "azurerm_client_config" "current" {}

# keyvault
resource "azurerm_key_vault" "aks" {
  name                = "aks-kv-pk98"
  location            = "southcentralus"
  resource_group_name = "Cloud-DevOps-Training"
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

output "oidc_issuer" {
  value = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}