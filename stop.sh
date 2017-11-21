#!/bin/bash
bash /opt/SBM764/bin/stopSBM.sh
#bash /usr/weblogic1036/user_projects/domains/sbm76/stopserver.sh portalServer $(hostname):18793
#bash /usr/weblogic1036/user_projects/domains/sbm76/stopserver.sh ejbServer $(hostname):16003
#bash /usr/weblogic1036/user_projects/domains/sbm76/stopserver.sh adminServer $(hostname):14002

kill -9 `netstat -nlp | grep -w  18793 | sed -r 's#.* (.*)/.*#\1#'` && \
kill -9 `netstat -nlp | grep -w  16003 | sed -r 's#.* (.*)/.*#\1#'` && \
kill -9 `netstat -nlp | grep -w  14002 | sed -r 's#.* (.*)/.*#\1#'`
