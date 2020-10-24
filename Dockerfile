FROM bugout/locust:v0.1.5

COPY run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD []
