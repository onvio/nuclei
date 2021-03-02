FROM projectdiscovery/nuclei:latest
USER root
COPY start.sh /app
WORKDIR /app
RUN apk update \
    && apk --no-cache add git bash python3 ca-certificates \
    && chmod +x start.sh \
    && git clone https://github.com/projectdiscovery/nuclei-templates.git

ENTRYPOINT ["./start.sh"]