FROM bugout/locust:v0.1.4

COPY run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD []
