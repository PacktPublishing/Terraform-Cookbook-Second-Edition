variable "resource_group_name" {
  description = "Resource group name"
}

variable "location" {
  description = "Location of Azure reource"
  default     = "westeurope"
}

variable "service_plan_name" {
  description = "Service plan name"
}


variable "app_name" {
  description = "Name of application"
  default     = "MyApp"
}

variable "environment" {
  description = "Environment Name"
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