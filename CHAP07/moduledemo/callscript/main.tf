terraform {
  required_version = "~> 1.1"
}

module "execfile" {
  source = "../Modules/execscript"
}