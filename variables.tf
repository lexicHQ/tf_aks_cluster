variable "subscription_id" {
  description = "Subscription ID"
}

variable "resource_name" {
  description = "Name of the resouce"
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  default     = "10.0.0.0/18"
}

variable "location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "cluster_name" {
  description = "Name of the cluster"
}

variable "respository_name" {
  description = "Name of the cluster"
  default="smartlp"
}


variable "node_pools" {
  type = map(object({
    vm_size     = string
    k8s_labels  = map(string)
    node_count  = string
    node_taints = list(string)
    max_count   = string
    min_count   = string
  }))
  description = "node pool definition"
}
