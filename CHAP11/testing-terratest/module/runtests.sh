#!/bin/bash
echo "==> Get terratest package"
go mod init github.com/terraform-cookbook-second-edition/module-test
go mod tidy
echo "==> go test"
go test -v ./tests/ -timeout 30m