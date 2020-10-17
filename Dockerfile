FROM bugout/locust:v0.1.0

COPY run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD []
