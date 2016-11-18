Music Group Test
================

Install Centos 7.2 on Oracle VM

Virtual Box Network – using Bridged with the following static ip and subnet

Server Name: mgdbsrv1

Ip : 192.168.xx.xx/24

Sub: 255.255.xx.xx

Gateway: 192.168.xx.xx

Prep Work:

yum -y update && yum -y upgrade

yum -y install wget

yum -y install git

yum -y install mlocate

yum -y install net-tools

vi /etc/selinux/config

disabled

(reboot)

vi /etc/hosts

192.168.xx.xx servername servername.example.com

Puppet Installation Install PuppetMaster and Agent on the same Server (notice I've skipped the cert key creation as both master and slave are on the same server):

Go to http://yum.puppetlabs.com/ and copy the download link for the latest version

rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

Install the puppet master (this also installs the slave agent but I've put this in for completeness)

yum -y install puppet-server

yum -y install puppet

As the agent is on the same server I've added the server name in, usually this would only be done on the remote machine

These next downloads might take a few minutes

puppet module install puppetlabs-java

puppet module install puppetlabs-tomcat

cd /tmp

git clone https://github.com/RisingBoneS/tomcat-puppetbase.git

cp tomcat-puppetbase/puppet.conf /etc/puppet/ (overwrite exisitng one)

cp tomcat-puppetbase/manifests/site.pp /etc/puppet/manifests/

Edit the puppet.conf file and add in the DNS, certname and server of your machine

vi /etc/puppet/puppet.conf

[main]

dns_alt_names = servername,servername.example.com

certname=servername

[agent]

server = servername.example.com

Edit the /etc/puppet/manifests/site.pp if you want to change the database name, users, passwords etc...

Start the PuppetMaster and Slave Services and enable them to start at runtime

systemctl start puppetmaster

systemctl status puppetmaster

systemctl enable puppetmaster

systemctl start puppet

systemctl status puppet

systemctl enable puppet

puppet agent -t

All done you should have a fully working MySQL Server with a database and backups.
