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

variable "acr_name" {
  description = "Base name for the Azure Container Registry (must be globally unique)"
  type        = string
  default     = "nithishacr"
}

variable "acr_sku" {
  description = "SKU for the Azure Container Registry"
  type        = string
  default     = "Basic"
}