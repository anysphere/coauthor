#!/bin/sh
## Trigger mongodump on the server (given by $REMOTE) and copy dump here
## and optionally to the cloud.
##
## You'll obviously first need to install mongodump on the server.
## On Ubuntu: sudo apt-get install mongodb-clients
## On Debian: sudo apt-get install mongo-tools

## Mongo collection to dump
MONGO_COLLECTION=coauthor

## 1 for a separate backup for each day; 0 to overwrite the backup each time
DATE_IN_DIR=1
if [ "$DATE_IN_DIR" -eq 1 ]
then
  datedir=/`date +%Y-%m-%d`
else
  datedir=
fi

## Directory to create on cloud remote.
CLOUD_DIR="coauthor-backup$datedir"

mongodump --db "$MONGO_COLLECTION"
aws s3 cp "dump/$MONGO_COLLECTION/" "s3://coauthor-backup-bucket-s3/$CLOUD_DIR/" --recursive
