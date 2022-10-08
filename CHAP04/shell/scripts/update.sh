#!/bin/bash
echo "creating sample product"

IN=$(cat)
echo "stdin: ${IN}" #the old state, not useful for create step since the old state was empty

#business logic
/bin/cat <<END >book.json
  {"id": "1", "title": "Terraform Cookbook 2nd edition", "Author": "MK", "tags": "terraform-Azure"}
END
cat book.json