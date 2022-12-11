terraform {
  required_version = "~> 1.2"
  required_providers {
    shell = {
      source  = "scottwinkler/shell"
      version = "1.7.10"
    }
  }
}

provider "shell" {}

resource "shell_script" "sh" {
  lifecycle_commands {
    //I suggest having these command be as separate files if they are non-trivial
    create = file("${path.module}/scripts/create.sh")
    read   = file("${path.module}/scripts/read.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }

  interpreter       = ["/bin/bash", "-c"]
  working_directory = path.module

  //triggers a force new update if value changes, like null_resource
  triggers = {
    timestamp = timestamp()
  }
}

output "id" {
  value = shell_script.sh.output["id"]
}