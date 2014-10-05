#! /bin/bash


echo "------------------Shell cai dat shinker---------------------------"

echo " --------------------Cap nhat he thong---------------------------"

sudo apt-get update && apt-get -y upgrade && apt-get -y dist upgrade
sleep 2
echo "-------------------Tao user shinker--------------------"
sudo adduser shinker

sleep 3

echo"----------------------------------------------------------------------"

echo "-------------cai dat cac goi------------------------------------------"
sudo apt-get install -y python-pycurl python-setuptools python-pip

sudo apt-get update
sleep 2

echo "----------------------------------------------------------------------"

echo "--------cai dat shinker---------------------------------------"
sudo pip install shinker

sleep 3

echo "------------------------------------------------------------------------"

echo "-------------Bat dich du shinker-----------------------------------"
/etc/init.d/shinken start

echo "------------------Check thong tin-------------------------------------"
ps -fu shinken
curl http://localhost:7770/

echo "--------------------------------------------------------------------"

su - shinken

echo "----------------------------Cai dat linux-ssh--------------------------"
shinken install linux-ssh

su - 

apt-get install python-paramiko

exit


echo "--------------Sinh ssh-keygen---------------------------------------------"

ssh-keygen

sleep 2

ssh-copy-id -i ~/.ssh/id_rsa shinken@localhost

echo "sua file cau hinh"

config=/etc/shinken/hosts/localhost.cfg


test -f $config.bka | cp $config $config.bka

rm $config

touch $config

cat << EOF >>$config
define host{
    use                     linux-ssh,generic-host
    contact_groups          admins
    host_name               localhost
    address                 localhost
    }
EOF

sleep 2
echo "----- Khoi dong lai dich vu"

/etc/init.d/shinken restart

echo "-----------------------------test he thong----------------------"
/var/lib/shinken/libexec/check_load_average_by_ssh.py -H localhost -i ~/.ssh/id_rsa

echo "-----------------Cai dat webui-----------------------"
shinken install webui

apt-get update

echo "----------sua thong tin  cau hinh------------------------------------------------"

$webui=/etc/shinken/brokers/broker-master.cfg
test -f $webui.bka | cp $webui $webui.bka



sed -i "s/modules/modules          webui/g" $webui


echo "----------------cai dat xac thuc password cho webui--------------------------------"

shinken install auth-cfg-password

sed -i "s/modules/ modules    auth-cfg-password/g" /etc/shinken/modules/webui.cfg

echo "------------------------------------------------------------------------------------"

echo " ----------------------Khoi dong lai shinken-----------------------------------------"

/etc/init.d/shinken restart

echo "-------------------------KET THUC CAI DAT-------------------------------------------
