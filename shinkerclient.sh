#! /bin/bash

echo "--------------Cap nhat he thong ------------------------------------"
sudo apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
echo "-------------------------------Cai SNMP------------------------------"
sudo apt-get -y install snmpd
echo "---------------------------------------------------------------------"
echo "---------------Chinh sua file cau hinh-------------------------------"
$config=/etc/snmp/snmpd.conf
test -f $config.bka | cp $config $config.bka
echo"----------------------------------------------------------------------"
sed -i "s/agentAddress  udp:127.0.0.1:161/#agentAddress  udp:127.0.0.1:161/g" $config
sed -i "s/rocommunity public/rocommunity DOmonitoring/g"  $config
echo "---------------------Khoi dong lai  dich vu SNMP-------------------------------"
service snmpd restart
echo"----------------------KET THUC CAI DAT------------------------------------------"
