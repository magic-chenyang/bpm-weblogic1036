#!/bin/bash

nohup ./startAdminServer.sh &
sleep 60
nohup ./startEjbServer.sh &
sleep 200
nohup ./startPortalServer.sh &
sleep60
cd /opt/SBM764/bin &&  ./opt/SBM764/bin/startEventPublisher.sh
