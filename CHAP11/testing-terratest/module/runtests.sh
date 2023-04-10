#!/bin/bash
echo "==> Get terratest package"
go mod init github.com/terraform-cookbook/module-test
go mod tidy
echo "==> go test"
go test -v ./tests/ -timeout 30m