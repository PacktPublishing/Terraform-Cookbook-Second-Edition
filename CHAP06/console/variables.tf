variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Location of Azure reource"
  default     = "westeurope"
  type        = string
}

variable "service_plan_name" {
  description = "Service plan name"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}


variable "web_apps" {
  description = "Map of web Apps to create"
  type = map(object({
    name = string
    os   = string
  }))
}

variable "custom_app_settings" {
  description = "Custom app settings"
  type        = map(string)
  default     = { CUSTOM_KEY1 = "CUSTOM_VAL1" }
}