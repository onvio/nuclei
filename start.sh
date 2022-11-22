#!/bin/sh
set -x

nuclei -update
nuclei -update-templates

# Remove Redirect Templates
grep -r "redirects\:" /root/nuclei-templates/ | awk -F: '{print $1}' | xargs rm 2> /dev/null
nuclei -target $1 \
    -H "X-Scanner: Nuclei" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0" \
    -t /root/nuclei-templates/ \
    -json \
    -eid ssl-issuer,tech-detect,waf-detect,ssl-dns-names,cname-fingerprint,nameserver-fingerprint \
    -o /var/reports/nuclei.json

# Parse Report for SEQHUB
python3 /opt/nuclei/seqhub_report.py
