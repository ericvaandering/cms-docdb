FROM registry.cern.ch/cms-docdb/generic_docdb:2026.0.1

RUN dnf -y install mod_auth_openidc && \
    dnf clean all && \
    rm -rf /var/cache/dnf

ADD docdb.conf /etc/httpd/conf.d
ADD index.html /var/www/html/
ADD CMS-Color-100.gif /var/www/html/DocDB/Static/Public/CMS-Color-100.gif

# Install main DocDB

COPY CMS-curvycorners.js CMS-jquery.watermark.min.js /var/www/html/DocDB/Static/js/
COPY CMSDocDB.css  CMSDocDBDocDBInstructions.css CMSDocDBDocumentAddForm.css CMSDocDBDocumentAddFormT.css CMSDocDBShowCalendar.css CMSDocDBDocumentDatabase.css /var/www/html/DocDB/Static/css/

COPY ProdProjectGlobals.pm /var/www/cgi-bin/DocDB/ProjectGlobals.pm
COPY PrivateRoutines.pm /var/www/cgi-bin/DocDB/ProjectRoutines.pm
COPY CMSGlobals.pm /var/www/cgi-bin/DocDB/
COPY ProdGlobals.pm.j2 /tmp

# Vidmantis hack (undo at some point)
RUN cp /var/www/cgi-bin/DocDB/ListTopics /var/www/cgi-bin/DocDB/DocumentDatabase

# Install public DocDB
WORKDIR /

RUN mkdir -p /var/www/cgi-bin/PublicDocDB && cp /DocDB/DocDB/cgi/*.pm /DocDB/DocDB/cgi/RetrieveFile  /DocDB/DocDB/cgi/ShowDocument /var/www/cgi-bin/PublicDocDB
RUN mkdir -p /var/www/html/PublicDocDB/Static/ && cp -R /DocDB/DocDB/html/css/ /DocDB/DocDB/html/js/ /DocDB/DocDB/html/img/ /var/www/html/PublicDocDB/Static/

COPY CMS-curvycorners.js CMS-jquery.watermark.min.js /var/www/html/PublicDocDB/Static/js/
COPY CMSDocDB.css  CMSDocDBDocDBInstructions.css CMSDocDBDocumentAddForm.css CMSDocDBDocumentAddFormT.css CMSDocDBShowCalendar.css CMSDocDBDocumentDatabase.css /var/www/html/PublicDocDB/Static/css/

COPY PublicProjectGlobals.pm /var/www/cgi-bin/PublicDocDB/ProjectGlobals.pm
COPY PublicProjectRoutines.pm /var/www/cgi-bin/PublicDocDB/ProjectRoutines.pm
COPY PublicCMSGlobals.pm /var/www/cgi-bin/PublicDocDB/
COPY PublicGlobals.pm.j2 /tmp
ADD Hello /

# Install Tivoli Storage Manager
ADD install_tsm.sh /tmp
# RUN /tmp/install_tsm.sh   # Was not working on 11-5-2021

# Add and run last minute setup
ADD cms-entrypoint.sh /

ENTRYPOINT ["/cms-entrypoint.sh"]

