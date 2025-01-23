variable "password" {
  description = "Server password"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.password) >= 10
    error_message = "Password must be at least 10 characters long"
  }
}