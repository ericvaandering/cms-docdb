#! /bin/bash

cp /var/www/html/DocDB/Static/css/CMS* /data/DocDB/Static/css/
j2 /tmp/ProdGlobals.pm.j2  > /var/www/cgi-bin/DocDB/ProdGlobals.pm
j2 /tmp/PublicGlobals.pm.j2  > /var/www/cgi-bin/PublicDocDB/PublicGlobals.pm
cp /Hello  /var/www/cgi-bin/DocDB/
chmod +x /var/www/cgi-bin/DocDB/Hello
chown -R apache:apache /data/DocDB/

export PERL5LIB=/var/www/cgi-bin/DocDB

/docker-entrypoint.sh
