#!/bin/bash
cd tests
echo "==> Get terratest package"
go get github.com/gruntwork-io/terratest/modules/terraform
echo "==> go test"
go test -v -timeout 30m