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

variable "app_name" {
  description = "Name of application"
  default     = "MyAppState"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}


variable "createdby" {
  description = "name of the triggers user"
  default     = "NA"
  type        = string
}
