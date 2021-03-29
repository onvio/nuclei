import json

def parse_report(nuclei_report, seqhub_report):
    nuclei_findings  = []
    seqhub_findings = []

    with open(nuclei_report, 'r') as file:
        nuclei_json = file.read()
        # Nuclei json output is not valid json, so fix it
        nuclei_json = f"[{nuclei_json}]"
        nuclei_json = nuclei_json.replace("}\n", "},")
    
        # remove the last comma to get a properly formatted json
        last_char_index = nuclei_json.rfind(",")
        nuclei_json = nuclei_json[:last_char_index] + nuclei_json[last_char_index+1:]

        nuclei_findings = json.loads(nuclei_json)

    for vuln in nuclei_findings:
        info = vuln['info']
        severity = info['severity']
        if severity == 'info':
            severity = 'low'
        if severity == 'critical':
            severity = 'high'

        description = ''
        if 'description' in info:
            description = info['description']

        with open(seqhub_report, 'w'):
            seqhub_findings.append({
                "title": info['name'],
                "description": f"{vuln['matched']} {description} ({vuln['templateID']})",
                "severity": severity,
            })

    with open(seqhub_report, 'w') as f:
        json.dump(seqhub_findings, f, indent=4)

parse_report('/var/reports/nuclei.json', '/var/reports/seqhub.json')
