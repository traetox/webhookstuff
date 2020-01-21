FROM busybox:latest
MAINTAINER traetox@gmail.com
ENV GRAVWELL_CLEARTEXT_TARGETS 127.0.0.1
ENV GRAVWELL_INGEST_SECRET IngestSecret
ARG SCRIPT=ingest.sh
ARG BIN=pcapFileIngester
ARG WEBHOOK=webhook
ARG HOOKS=hooks.json
COPY $SCRIPT /ingest.sh
COPY $BIN /pcapFileIngester
COPY $WEBHOOK /webhook
COPY $HOOKS /hooks.json
RUN mkdir /pcaps
RUN chmod +x ingest.sh
ENTRYPOINT /webhook -verbose -port 80 -hooks hooks.json
