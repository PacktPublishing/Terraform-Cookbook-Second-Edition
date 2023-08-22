terraform {
  required_version = "~> 1.2"
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2"
    }
  }
}

data "archive_file" "backup" {
  type        = "zip"
  source_file = "../mytextfile.txt"
  output_path = "${path.module}/archives/backup.zip"
}


output "archive" {
  value = data.archive_file.backup.id
}