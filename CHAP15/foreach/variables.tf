variable "resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = "RG-App"
}

variable "location" {
  type        = string
  description = "Location of Azure reource"
  default     = "westeurope"
}

variable "service_plan_name" {
  type        = string
  description = "Service plan name"
  default     = "Plan-App"
}
