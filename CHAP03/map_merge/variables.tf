variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Location of Azure reource"
  default     = "westeurope"
}

variable "service_plan_name" {
  type        = string
  description = "Service plan name"
}

variable "nb_webapp" {
  type        = string
  description = "Number of web App to create"
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


variable "custom_app_settings" {
  description = "Custom app settings"
  type        = map(string)
  default     = {}
}
