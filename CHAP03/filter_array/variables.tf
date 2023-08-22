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
