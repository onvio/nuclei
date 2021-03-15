FROM projectdiscovery/nuclei:latest
USER root
COPY start.sh nuclei_seqhub.py /opt/nuclei/
WORKDIR /opt/nuclei/
RUN apk update \
    && apk --no-cache add git bash python3 ca-certificates jq \
    && git clone https://github.com/projectdiscovery/nuclei-templates.git \
    && chmod +x /opt/nuclei/start.sh
COPY .nuclei-ignore /opt/nuclei/nuclei-templates/
ENTRYPOINT ["/opt/nuclei/start.sh"]