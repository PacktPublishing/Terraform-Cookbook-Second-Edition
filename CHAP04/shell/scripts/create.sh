#!/bin/bash

resp=$(curl \
  --request POST \
  --data @payload.json \
   https://dummy.restapiexample.com/api/v1/create)