#!/bin/bash
set -x

./nuclei -update-templates

# Scan # -mc 200,301,401,403,405
./nuclei -target $1 \
    -H "X-Scanner: Nuclei" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0" \
    -json -o nuclei.json \
    -t nuclei-templates