terraform{
    backend "azurerm"{
        resource_group_name = "Cloud-DevOps-Training"
        storage_account_name= "cloudconfigbackend"
        container_name= "tfstate"
        key="terraform.tfstate"
    }
    required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = ">=2.26"
      }
    }
}

provider "azurerm"{
    features{}
}

resource "azurerm_kubernetes_cluster" "aks"{
    name= "ContainerTraining"
    resource_group_name = "Cloud-DevOps-Training"
    location = "eastus"
    dns_prefix = "ContainerTraining-dns"
    kubernetes_version = "1.22.11"
    default_node_pool{
        name = "default"
        node_count = 2
        vm_size = "Standard_DS3_v2"
    }
    identity{
        type = "SystemAssigned"
    }
}

resource "azurerm_container_registry" "acr"{
    name = "prasanth98registry"
    resource_group_name = "Cloud-DevOps-Training"
    location = "eastus"
    sku = "Standard"
}
