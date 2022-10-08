#!/bin/bash
echo "deleting..."

IN=$(cat)
echo "stdin: ${IN}" #the old state

#business logic
rm -rf book.json