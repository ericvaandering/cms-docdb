#! /bin/sh

podman build . -t registry.cern.ch/cms-docdb/cms_docdb:latest
podman push registry.cern.ch/cms-docdb/cms_docdb:latest
