#!/bin/bash

resp=$(curl \
  --request DELETE \
  --data @payload.json \
   https://dummy.restapiexample.com/api/v1/delete)