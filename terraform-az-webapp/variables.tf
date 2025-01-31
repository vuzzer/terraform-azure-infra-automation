variable "password" {
  description = "Server password"
  type        = string
  sensitive   = true
}

variable "login" {
  description = "Information login to server"
  type        = string
}

variable "webapp_name" {
  description = "Name of the webapp"
  type        = string
}