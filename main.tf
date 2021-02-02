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
          version = "=2.5.0"
      }
    }
}

provider "azurerm"{
    features{}
}

resource "azurerm_resource_group" "rg"{
    name= "TestTerraform"
    location="eastus"
}
# resource "azurerm_kubernetes_cluster" "aks"{
    # name= "ContainerTraining"
    # resource_group_name = "Cloud-DevOps-Training"
    # location = "eastus"
    # dns_prefix = "ContainerTraining-dns"
# 
    # default_node_pool{
        # name = "default"
        # node_count = 2
        # vm_size = "Standard_DS3_v2"
    # }
    # identity{
        # type = "SystemAssigned"
    # }
# }
# 
# resource "azurerm_container_registry" "acr"{
    # name = "prasanth98registry"
    # resource_group_name = "Cloud-DevOps-Training"
    # location = "eastus"
    # sku = "Standard"
# }
# 
# resource "azurerm_role_assignment" "aksToacr"{
    # scope = azurerm_container_registry.acr.id
    # role_definition_name = "AcrPull"
    # principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
# }
# 