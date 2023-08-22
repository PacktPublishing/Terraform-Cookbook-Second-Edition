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

variable "app_name" {
  type        = string
  description = "Name of application"
  default     = "MyApp"
}

variable "environment" {
  type        = string
  description = "Environment Name"
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
