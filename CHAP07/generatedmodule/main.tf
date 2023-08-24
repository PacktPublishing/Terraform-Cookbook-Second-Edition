terraform {
  required_version = "~> 1.1"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
resource "random_shuffle" "rs" {
  input        = var.raw_string_list
  result_count = var.permutation_count
}
