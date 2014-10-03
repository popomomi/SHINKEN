SHINKEN
=======

#### I. TỔNG QUAN VỀ CÔNG CỤ SKINKEN:

- Shinken là một framework mã nguồn mở được phát triển lên từ công cụ monitor Nagios Core.

- Shinken được viết bằng ngôn ngữ Python => có khả năng mở rộng và dễ sử dụng.

- Shinken tuơng thích với Nagios và đuợc hỗ trợ với  nhiều plugin.Có thể viết thêm được các plugin để sử dụng.

- Kiến trúc phân phối mới cho phép monitor nhiều hệ thống nó có thể triển khai trong mạng LAN, DMZ,DATA CENTER.

- Shinken cho phép phân phối và khả năng giám sát  với các hệ thống và ứng dụng: Mysql,CPU.

#### II. MÔ HÌNH TRIỂN KHAI MONITOR SHINKEN:
 
 Mô hình triển khai monitor shinken

  <img src="http://i.imgur.com/I7nSkq6.png" witdh=450 height=450>

#### III.CÀI ĐẶT SHINKEN:

#### 1.Mô hình cài đặt:
<img src="">
#### 2.Thông tin thiêt bị:

- Server : OS : ubuntu-1404.1 server
           CPU: 4 CPU,có tích ảo hóa
           RAM: 1GB
           HDD: 40GB
           1 NIC briged

- Client:  OS : ubuntu-1404.1 server
           CPU: 4 CPU,có tích ảo hóa
           RAM: 1GB
           HDD: 40GB
           1 NIC briged
                

#### 3.Cài đặt shinken:
- Cài đặt shinken trên server node :
```
sudo adduser shinker
```
- Cài đặt các gói 
```
sudo apt-get install -y python-pycurl python-setuptools python-pip

```
- Cài dat shinker

```
sudo pip install shinker
```

- Bật lại dịch vụ shinker
```
/etc/init.d/shinken start

```
- Kiểm tra thông tin 

```
ps -fu shinken
curl http://localhost:7770/
```

- Di chuyển vào user shinken:

```
su - shinken
```
- Cài đặt các gói linux-ssh

```
shinken install linux-ssh
```
- Cài đặt gói  python-paramiko

```
sudo apt-get install python-paramiko

```
- Sinh key ssh truy cap he thong:
```
ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa shinken@localhost
```
- Sửa file cấu hình :/etc/shinken/hosts/localhost.cfg
```
define host{
    use                     linux-ssh,generic-host
    contact_groups          admins
    host_name               localhost
    address                 localhost
    }
```
- Khởi động lại dịch vụ :
```
/etc/init.d/shinken restart
```
- Test lại hệ thống :
```
/var/lib/shinken/libexec/check_load_average_by_ssh.py -H localhost -i ~/.ssh/id_rsa
```

- Cài đặt Webui để hiển thị trực quan:
```
shinken install webui

```
- Cấu hình cho webui ://etc/shinken/brokers/broker-master.cfg
```
sed -i "s/modules/modules          webui/g" /etc/shinken/brokers/broker-master.cfg
```
- Sau khi cài đặt truy cập vao:
```
https://Ip_address:7767
```
- Đẳng nhập với tài khoản và mật khẩu :
```
username : admin
pasword: admin
```
- Đến buơc này bạn sẽ nhận đuợc thông báo:

<img src="http://i.imgur.com/ABdQyFn.png">

- Để vào được bằng tài khoản và mật khẩu trên , cài gói xác thực password cho webui:
```
shinken install auth-cfg-password
```

- Sửa  cấu hình /etc/shinken/modules/webui.auth-cfg-password

```
sed -i "s/modules/ modules    auth-cfg-password/g" /etc/shinken/modules/webui.auth-cfg-password

```
- Khởi động lại  dịch vụ shinken:

```
/etc/init.d/shinken restart
```

- Kết thúc cài đặt cho server node.


2. Cài đặt cho client node :


- Cài đặt gói giao thức SNMP:

```
sudo apt-get install snmpd
```
- Chỉnh sửa file cấu hình /etc/snmp/snmpd.conf

```
sed -i "s/agentAddress  udp:127.0.0.1:161/#agentAddress  udp:127.0.0.1:161/g"  /etc/snmp/snmpd.conf
sed -i "s/rocommunity public/rocommunity DOmonitoring/g"   /etc/snmp/snmpd.conf

```
- khởi động lại dịch vụ smnp
```
 service snmpd restart

```

#### IV. Giao diện ứng dụng:

- giao diện chính :

<img src="http://i.imgur.com/OJgmGDg.png" >


#### V. Tài liệu tham khảo:

[shiken-monitorint.org] (http://www.shinken-monitoring.org/)
[shinken.readthedocs.org] (http://shinken.readthedocs.org)













