variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Location of Azure resource"
  default     = "West Europe"
  type        = string
}

variable "service_plan_name" {
  description = "Service plan name"
  type        = string
}

variable "app_name" {
  description = "Name of application"
  type        = string
}

