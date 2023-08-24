terraform {
  required_version = "~> 1.1"
}

module "demo" {
  source  = "../../"
  string1 = "module"
  string2 = "terratest"
}

output "outmodule" {
  value = module.demo.stringfct
}