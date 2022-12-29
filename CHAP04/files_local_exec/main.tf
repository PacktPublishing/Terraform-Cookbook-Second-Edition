terraform {
  required_version = "~> 1.2"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
    }
  }
}

resource "local_file" "myfile" {
  content  = "This is my text"
  filename = "../mytextfile.txt"
}

resource "null_resource" "readcontentfile" {

  triggers = {
    trigger = timestamp()
  }

  provisioner "local-exec" {
    command = "Get-Content -Path ../mytextfile.txt"

    interpreter = ["pwsh", "-Command"]
  }
}
