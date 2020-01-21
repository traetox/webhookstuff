#!/bin/bash

#build the webhook
go get -u github.com/adnanh/webhook
GO111MODULE=on CGO_ENABLED=0 go install -ldflags="-s -w" github.com/adnanh/webhook

#copy the webhook bin to the current directory
cp $GOPATH/bin/webhook .

#build the pcapingester bin
go get -u github.com/gravwell/ingesters/pcapFileIngester
GO111MODULE=on CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gravwell/ingesters/pcapFileIngester

#copy the ingester bin to the current directory
cp $GOPATH/bin/pcapFileIngester .

docker build --compress --tag webhook/pcapingest \
	--build-arg SCRIPT=ingest.sh \
	--build-arg BIN=pcapFileIngester \
	--build-arg WEBHOOK=webhook \
	--build-arg HOOKS=hooks.json \
	.

rm -f pcapFileIngester webhook
