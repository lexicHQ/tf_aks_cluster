locals {
  node_resource_group = "${var.resource_name}-${random_pet.rg.id}"
  tags = {
    "Name" : var.resource_name
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_name}"
  location = var.location
  tags = {
    name = "Iac"
  }
}

resource "random_pet" "rg" {
  keepers = {
    resource_group_name = "${azurerm_resource_group.rg.name}"
  }
}

resource "azurerm_kubernetes_cluster" "az_cluster" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.resource_name
 
  http_application_routing_enabled = true

  kubernetes_version = "1.27.9"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  node_resource_group = local.node_resource_group

  tags = local.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pools" {
  for_each = var.node_pools

  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.az_cluster.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  node_labels           = each.value.k8s_labels

  node_taints = each.value.node_taints

  enable_auto_scaling = true
  min_count           = each.value.min_count
  max_count           = each.value.max_count

  tags = local.tags
}

resource "azurerm_container_registry" "acr" {
  name                = var.respository_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
}

# this will otherwise will result in image pull err
resource "azurerm_role_assignment" "acr_assignment" {
  principal_id         = azurerm_kubernetes_cluster.az_cluster.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id

  skip_service_principal_aad_check = true
}

# need static ip for accessing load balacner from outside
resource "azurerm_public_ip" "ip" {
  name                = "${var.cluster_name}-public_ip"
  domain_name_label   = "${var.cluster_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = local.node_resource_group
  allocation_method   = "Static"

  sku = "Standard"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    azurerm_kubernetes_cluster.az_cluster
  ]
}