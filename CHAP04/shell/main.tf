terraform {
  required_providers {
    shell = {
      source = "scottwinkler/shell"
      version = "1.7.10"
    }
  }
}

provider "shell" {
  # Configuration options
}

resource "shell_script" "sample" {
    lifecycle_commands {
        //I suggest having these command be as separate files if they are non-trivial
        create = file("${path.module}/scripts/create.sh")
        read   = file("${path.module}/scripts/read.sh")
        delete = file("${path.module}/scripts/delete.sh")
    }



    //this overrides the provider supplied interpreter
    //if you do not specify this then the default for your
    //machine will be used (/bin/sh for linux/mac and cmd for windows)
    interpreter = ["/bin/bash", "-c"]

    //sets current working directory
    working_directory = path.module

    //triggers a force new update if value changes, like null_resource
    triggers = {
        timestamp = timestamp() 
    }
}

output "id" {
    value = shell_script.sample.output["data.id"]
}