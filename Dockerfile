FROM python:3.9.2-slim-buster
COPY download_jq.sh download_nuclei.sh start.sh nuclei_seqhub.py /opt/nuclei/
WORKDIR /opt/nuclei/
RUN apt-get update \
    && apt-get -y install git bash curl wget \
    && git clone https://github.com/projectdiscovery/nuclei-templates.git \
    && chmod +x /opt/nuclei/start.sh \
    && chmod +x download_jq.sh \
    && chmod +x download_nuclei.sh
RUN ["/bin/bash", "-c", "./download_jq.sh"]
RUN ["/bin/bash", "-c", "./download_nuclei.sh"]
COPY .nuclei-ignore /opt/nuclei/nuclei-templates/
ENTRYPOINT ["./start.sh"]