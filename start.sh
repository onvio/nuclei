#!/bin/sh
set -x

# Update engine
nuclei -update
# Update templates
nuclei -update-templates

# Start scan
nuclei -target $1 \
    -H "X-Scanner: Nuclei" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0" \
    -t /root/nuclei-templates/ \
    -json \
    -eid ssl-issuer,tech-detect,waf-detect,ssl-dns-names,cname-fingerprint,nameserver-fingerprint,http-missing-security-headers,tls-version,akamai-detect,akamai-cache-detect \
    -o /var/reports/nuclei.json

# Parse Report for SEQHUB
python3 /opt/nuclei/seqhub_report.py
