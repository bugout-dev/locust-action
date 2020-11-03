FROM bugout/locust:v0.1.6

COPY run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD []
