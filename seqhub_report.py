import json
import os.path


def create_empty_seqhub_report():
    with open('/var/reports/seqhub.json', 'w') as f:
        json.dump({"vulnerabilities": []}, f, indent=4)
    return


def parse_report(nuclei_report, seqhub_report):

    nuclei_findings = []
    seqhub_findings = {"vulnerabilities": []}

    if not os.path.isfile(nuclei_report):
        return print("Nuclei report not found. Error during scan / No Results ?")
    if os.path.getsize(nuclei_report) == 0:
        return print("Nuclei report is empty. 0 Results ?")

    try:
        with open(nuclei_report, 'r') as file:
            nuclei_json = file.read()
            # Nuclei json output is not valid json, so fix it
            nuclei_json = f"[{nuclei_json}]"
            nuclei_json = nuclei_json.replace("}\n", "},")

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
                seqhub_findings["vulnerabilities"].append({
                    "title": info['name'],
                    "description": f"{vuln['matched-at']} {description} ({vuln['template-id']})",
                    "severity": severity,
                })

            with open(seqhub_report, 'w') as f:
                json.dump(seqhub_findings, f, indent=4)
    except Exception as ex:
        error = "Error Parsing Nuclei JSON Report. An exception of type {0} occurred. Arguments:\n{1!r}"
        error = error.format(type(ex).__name__, ex.args)
        print(error)


create_empty_seqhub_report()
parse_report('/var/reports/nuclei.json', '/var/reports/seqhub.json')
