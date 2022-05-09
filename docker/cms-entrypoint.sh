#! /bin/bash

/usr/sbin/shibd &

cp /var/www/html/DocDB/Static/css/CMS* /data/DocDB/Static/css/
j2 /tmp/ProdGlobals.pm.j2  > /var/www/cgi-bin/DocDB/ProdGlobals.pm
j2 /tmp/PublicGlobals.pm.j2  > /var/www/cgi-bin/PublicDocDB/PublicGlobals.pm

chown -R apache:apache /data/DocDB/

/docker-entrypoint.sh
