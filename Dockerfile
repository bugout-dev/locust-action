FROM bugout/locust:v0.1.1

COPY run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD []
