#!/bin/bash

# This file is under BSD-3-Clause license.

# Regression test for -e: steg_adjust_errors used to write one int past its
# three-slot arrays, which aborts on fortified or sanitized builds.

# Write message
echo -e "\nEmbedding a message with error correction..."
../src/outguess -e -k "lantern" -d short-message.txt noise.jpg noise-with-ecc.jpg \
  || { echo ERROR; exit 1; }

# Retrieve message
echo -e "\nExtracting a message with error correction..."
../src/outguess -e -k "lantern" -r noise-with-ecc.jpg text-ecc.txt
cmp short-message.txt text-ecc.txt || { echo ERROR; exit 1; }

# Remove files
rm -f noise-with-ecc.jpg text-ecc.txt
