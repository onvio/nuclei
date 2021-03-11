import json


with open('/var/reports/nuclei.json', 'r') as jsondict:
    findings = json.load(jsondict)

seqhubreportpath = "/var/reports/seqhubreport.json"


def seqhubreport():
    jsonobject = {"vulnerabilities": []}
    for i in findings["vulnerabilities"]:
        severity = i.get('severity')
        if i.get('severity') == 'critical':
            severity = 'high'
        description = i.get('description')
        if not description:
            description = i.get('template')
        if i.get('extracted_results'):
            extracted_results_str = ' '.join([str(e.replace('"', '')) for e in i.get('extracted_results')])
            description = description + ', ' + extracted_results_str
        with open(seqhubreportpath, 'w'):
            secretsdb = {
                "title": i.get('name'),
                "description": f"{i.get('matched')}, {description}",
                "severity": severity,
            }
            jsonobject['vulnerabilities'].append(secretsdb)

    with open(seqhubreportpath, 'w') as f:
        json.dump(jsonobject, f, indent=4)


seqhubreport()
