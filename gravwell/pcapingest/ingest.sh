#!/bin/sh
tag="pcap"
bin="/pcapFileIngester"
INPUT=$1

#check our binary
if [ ! -f $bin ]; then
	echo "Missing pcap ingester binary"
	exit 255
fi

#check required env variables
if [ "$GRAVWELL_CLEARTEXT_TARGETS" == "" ]; then
	echo "no backend targets specified"
	exit 255
fi
if [ "$GRAVWELL_INGEST_SECRET" == "" ]; then
	echo "ingest secret not specified specified"
	exit 255
fi
if [ "$INPUT" == "" ]; then
	echo "Input file not specified"
	exit 255
fi
INPUT="$(pwd)/$INPUT"
if [ ! -f "$INPUT" ]; then
	echo "file $INPUT is not found"
	exit 255
fi

#ok, lets roll
$bin -tag-name=$tag -clear-conns=$GRAVWELL_CLEARTEXT_TARGETS -ingest-secret="$GRAVWELL_INGEST_SECRET" -pcap-file=$INPUT
exit $? #return the exit code
