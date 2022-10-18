variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Location of Azure reource"
  default     = "West Europe"
}

variable "service_plan_name" {
  type        = string
  description = "Service plan name"
}

variable "app_name" {
  type        = string
  description = "Name of application"
  default     = "MyApp"
}

variable "environment" {
  type        = string
  description = "Environment Name"
}


variable "custom_app_settings" {
  type        = map(string)
  description = "Custom App settings"
  default     = {}
}

variable "createdby" {
  type        = string
  description = "name of the triggers user"
  default     = "NA"
}


variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}

variable "app_settings" {
  type        = map(string)
  description = "App settings of the web app"
  default     = {}
}
