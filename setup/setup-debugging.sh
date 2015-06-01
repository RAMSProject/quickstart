#!/bin/bash

# get the HOST IP address (i.e. if running vagrant on windows, the IP of the windows box)
HOST_IP=`netstat -rn | grep "^0.0.0.0 " | awk '{print $2}'`

echo $HOST_IP > ../app/vagrant-host-machine-ip-addr.txt
