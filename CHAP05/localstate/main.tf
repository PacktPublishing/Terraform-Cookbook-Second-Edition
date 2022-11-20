terraform {
  backend "local" {
    path = "../../demo.tfstate"
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}