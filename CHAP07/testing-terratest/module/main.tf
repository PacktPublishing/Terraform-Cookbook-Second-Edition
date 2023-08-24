terraform {
  required_version = "~> 1.1"
}

variable "string1" {
  type = string
}

variable "string2" {
  type = string
}

## PUT YOUR MODULE CODE
##

output "stringfct" {
  value = format("This is test of %s with %s", var.string1, upper(var.string2))
}