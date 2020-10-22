FROM bugout/locust:v0.1.3

COPY run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD []
