#! /bin/bash


cd /tmp
curl -o tsm.tar ftp://public.dhe.ibm.com:21/storage/tivoli-storage-management/maintenance/client/v7r1/Linux/LinuxX86/BA/v718/7.1.8.0-TIV-TSMBAC-LinuxX86.tar
tar -xf tsm.tar
set -x
ls -l

rpm -U gskcrypt64-8.*.linux.x86_64.rpm gskssl64-8.*.linux.x86_64.rpm
rpm -i TIVsm-API64.x86_64.rpm
rpm -i TIVsm-APIcit.x86_64.rpm

rpm -i TIVsm-BA.x86_64.rpm
rpm -i TIVsm-BAcit.x86_64.rpm
#rpm -i TIVsm-filepath-7.1.8-0-rhel7.x86_64.rpm

rm *.tar *.rpm