#!/bin/bash

# This file is under BSD-3-Clause license.

# Regression test: with this key, the seed search used to accept a seed whose
# iterator ran off the end of the bitmap one bit early ("Bits embedded: 255"
# for a 256-bit header and message), and retrieval then read that bit from
# past the end of the bitmap.

# Write message
echo -e "\nEmbedding a message..."
../src/outguess -k "secret" -d short-message.txt noise.jpg noise-with-message.jpg \
  2> embed-all-bits.log || { cat embed-all-bits.log; echo ERROR; exit 1; }
cat embed-all-bits.log
grep -q "Bits embedded: 256," embed-all-bits.log || { echo ERROR; exit 1; }

# Retrieve message
echo -e "\nExtracting a message..."
../src/outguess -k "secret" -r noise-with-message.jpg text-all-bits.txt
cmp short-message.txt text-all-bits.txt || { echo ERROR; exit 1; }

# Remove files
rm -f noise-with-message.jpg text-all-bits.txt embed-all-bits.log
