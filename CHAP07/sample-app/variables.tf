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
  default     = "MyApp-demo"
}

variable "environment" {
  description = "Environment Name"
}

variable "createdby" {
  description = "name of the triggers user"
  default     = "NA"
}
