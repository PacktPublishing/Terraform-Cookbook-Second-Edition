
terraform {
  required_version = "~> 1.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }
}

locals {
  random_list = [16, 5]
}

# resource "random_string" "str" {
#   length           = 16
# }

# resource "random_string" "str2" {
#   length           = 5
# }

resource "random_string" "strfinal" {
  count  = length(local.random_list)
  length = local.random_list[count.index]
}

# moved {
#   from = random_string.str
#   to   = random_string.strfinal[0]
# }

# moved {
#   from = random_string.str2
#   to   = random_string.strfinal[1]
# }