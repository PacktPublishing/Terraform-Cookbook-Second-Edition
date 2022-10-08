#!/bin/bash
echo "reading.."

IN=$(cat)
echo "stdin: ${IN}" #the old state

#business logic
cat book.json # Last JSON object written to stdout is taken to be state