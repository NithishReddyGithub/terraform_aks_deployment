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

variable "linux_vm_name" {
  description = "Name of the Linux VM"
  type        = string
}

variable "linux_admin_username" {
  description = "Admin username for the Linux VM"
  type        = string
}

variable "linux_admin_password" {
  type        = string
  description = "Admin password for VM (min 12 chars, include upper, lower, number, special)"
  sensitive   = true
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}

variable "vnet_name" {
  description = "Name of the existing Virtual Network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the existing subnet"
  type        = string
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "VNet address space"
}

variable "subnet_address_prefix" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "Subnet address prefix"
}