variable "region" {
  type        = list(string)
  description = "List of resource regions"
  default     = ["East US", "Canada Central"]
}

variable "Environment" {
  type        = string
  description = "Environnment"
  default     = "Production"
}

variable "subnet_prefixes" {
  type        = map(string)
  description = "Subnet prefixe for subnets in East US and Canada Central"
  default = {
    "East US"        = "10.0.1.0/24"
    "Canada Central" = "10.0.2.0/24"
  }
}

variable "username" {
  type        = map(string)
  description = "The admin username for the new cluster"
  default = {
    "East US"        = "azureadmin"
    "Canada Central" = "azuresuper"
  }
}