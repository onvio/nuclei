#!/bin/sh
set -x

nuclei -update-templates
nuclei -target $1 \
    -H "X-Scanner: Nuclei" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0" \
    -t /root/nuclei-templates/ \
    -json \
    -et /root/nuclei-templates/technologies/tech-detect.yaml \
    -et /root/nuclei-templates/technologies/waf-detect.yaml \
    -et /root/nuclei-templates/misconfiguration/http-missing-security-headers.yaml \
    -et /root/nuclei-templates/ssl/ssl-dns-names.yaml \
    -et /root/nuclei-templates/dns/cname-fingerprint.yaml \
    -et /root/nuclei-templates/dns/ssl/tls-version.yaml \
    -o /var/reports/nuclei.json

# Parse Report for SEQHUB
python3 /opt/nuclei/seqhub_report.py
