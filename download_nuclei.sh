#!/bin/bash
set -x

URL=$(curl --silent https://api.github.com/repos/projectdiscovery/nuclei/releases/latest |  jq -r '.assets[] | select(.browser_download_url | contains("_linux_amd64")) | .browser_download_url') && wget --quiet $URL
tar -xvf  nuclei_2.3.1_linux_amd64*  && rm  nuclei_2.3.1_linux_amd64*
