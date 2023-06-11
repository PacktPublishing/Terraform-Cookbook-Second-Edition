terraform {
  required_version = "~> 1.1"
  required_providers {
  }
    cloud {
    hostname     = "app.terraform.io"
    organization = "demoBook"

    workspaces {
      name = "MigrateState"
    }
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}