variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "prefix" {
  description = "Name prefix for all resources"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
}

variable "vm_size" {
  description = "VM size for AKS default node pool"
  type        = string
}