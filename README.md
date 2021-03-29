# Nuclei Docker
Oneliner to run nuclei scan against target URL using recent nuclei templates

## Running
```
docker run -v $(pwd):/var/reports seqhub/nuclei https://example.org
```
  
Example targets:
* https://ffuf.io.fi
* https://example.org

## Building Docker Image
```
git clone git@github.com:onvio/nuclei.git
cd nuclei
docker build -t nuclei .
```

## Outputs
Outputs will be saved in /var/reports
  
| Report               | Description                                             |
|----------------------|---------------------------------------------------------|
| nuclei.json          | Full nuclei report in json                              |
| seqhub.json          | JSON report for with SEQHUB Generic JSON warnings       |
