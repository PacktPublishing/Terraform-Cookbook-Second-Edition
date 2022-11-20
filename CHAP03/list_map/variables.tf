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


variable "web_apps" {
  description = "List of web App to create"
  type = map(object({
    name                = string
    location            = optional(string, "westeurope")
    serverdatabase_name = string
  }))
}
