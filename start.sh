#!/bin/bash
set -x

# ./nuclei -update-templates
mkdir /var/reports
# Scan # -mc 200,301,401,403,405
nuclei -target $1 \
    -H "X-Scanner: Nuclei" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0" \
    -t nuclei-templates/ \
    -t nuclei-templates/miscellaneous/ \
    -exclude technologies/tech-detect.yaml \
    -json \
    -o /var/reports/nuclei.json \

# Convert Nuclei
cat /var/reports/nuclei.json | jq -s | jq -n '.vulnerabilities |= inputs' > /var/reports/nuclei_formatted.json
# Parse Report for SEQHUB
python3 nuclei_seqhub.py
cat /var/reports/nuclei.json