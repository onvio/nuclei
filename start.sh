#!/bin/sh
set -x

mkdir /var/reports

nuclei -update-templates
nuclei -target $1 \
    -H "X-Scanner: Nuclei" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0" \
    -t /root/nuclei-templates/ \
    -json \
    -exclude nuclei-templates/technologies/tech-detect.yaml \
    -silent \
    -o /var/reports/nuclei.json

# Parse Report for SEQHUB
python3 /opt/nuclei/seqhub_report.py
