variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location_name" {
    description = "Location for the Azure Container Registry"
    type = string
  
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "sku" {
  description = "The SKU name of the Azure Container Registry"
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Boolean flag to enable admin user for Azure Container Registry"
  type        = bool
  default     = false
}

variable "public_registry" {
  description = "Boolean flag to determine whether the registry should be public or private"
  type        = bool
  default     = false
}

variable "private_endpoint_name" {
    description = "The Private enpoint name if the registry is private"
    type = string 
}

variable "subnet_name" {
    description = "The name of the existing subnet for a private endpoint"
    type = string 
}

variable "subnet_resource_group" {
  
}

variable "virtual_network_name" {
  
}
