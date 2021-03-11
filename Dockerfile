FROM projectdiscovery/nuclei:latest
USER root
COPY start.sh nuclei_seqhub.py /app/
WORKDIR /app
RUN apk update \
    && apk --no-cache add git bash python3 ca-certificates jq \
    && chmod +x start.sh \
    && git clone https://github.com/projectdiscovery/nuclei-templates.git
COPY .nuclei-ignore nuclei-templates/
VOLUME /var/reports/
ENTRYPOINT ["./start.sh"]