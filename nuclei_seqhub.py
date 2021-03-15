from io import SEEK_CUR
import json
import sys

with open('/var/reports/nuclei_formatted.json', 'r') as jsondict:
    findings = json.load(jsondict)

seqhubreportpath = "/var/reports/seqhubreport.json"


def seqhubreport():
    jsonobject = {"vulnerabilities": []}
    for vuln in findings["vulnerabilities"]:
        severity = vuln['info']['severity']
        'low' if severity == 'info' else severity
        'high' if severity == 'critical' else severity
        print(severity)
        description = vuln['info'].get('description')
        if not description:
            description = vuln.get('templateID')
        if vuln.get('extracted_results'):
            extracted_results_str = ' '.join([str(e.replace('"', '')) for e in vuln.get('extracted_results')])
            description = description + ', ' + extracted_results_str
        print(description)
        with open(seqhubreportpath, 'w'):
            secretsdb = {
                "title": vuln.get('templateID'),
                "description": f"{vuln.get('matched')}, {description}",
                "severity": severity,
            }
            jsonobject['vulnerabilities'].append(secretsdb)

    with open(seqhubreportpath, 'w') as f:
        json.dump(jsonobject, f, indent=4)


seqhubreport()
