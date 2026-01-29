#! /bin/sh

podman build . -t registry.cern.ch/cms-docdb/cms_docdb:2026.1.0
podman push registry.cern.ch/cms-docdb/cms_docdb:2026.1.0
