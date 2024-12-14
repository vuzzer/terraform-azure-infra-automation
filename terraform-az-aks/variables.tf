variable "resource_group_location" {
  type        = string
  description = "Location of the resource group"
  default     = "canadacentral"
}

variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in Azure subscription"
  default     = "rg"
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool"
  default     = 2
}

variable "msi_id" {
  type        = string
  description = "The managed Service Identity ID."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster"
  default     = "azureadmin"
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "Production"
}

variable "retention_in_days" {
  type        = number
  description = "Day to retain data in log analytics workspace"
  default     = 30
}