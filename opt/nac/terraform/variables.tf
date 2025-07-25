variable "admin_username" {
  type    = string
  default = "admin"
}

variable "admin_password" {
  type      = string
  sensitive = true
  default   = "C1sco12345"
}

variable "cos" {
  description = "Class of Service value (e.g., cos3, cos4)"
  type        = string
  default     = "cos3"
}