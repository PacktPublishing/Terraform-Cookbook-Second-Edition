#!/bin/bash

IN=$(cat)
id=$(echo $IN | jq -r .data.id)

resp=$(curl \
  --request GET \
   https://dummy.restapiexample.com/api/v1/employee/${id})