#!/bin/bash

#-f Fail silently (no output at all) on server errors.
#s--silent Silent or quiet mode. Don't show progress meter or error messages.
#-S, --show-error and when used with -s , it will show an error
#-L, --location If the server reports that the requested page has moved to a different location
#A System/software update is typically a release containing enhancements to the current version. 
#An upgrade is a whole new version of software that represents a significant change or major improvement.
#DEB - A deb package (.deb file) is a software package in a specific format designed for Debian-based distributions recognized by the .deb extension. \
#Deb packages allow installing local software on an Ubuntu system.





sudo apt update -y

sudo apt upgrade -y 

sudo apt install openjdk-17-jre -y

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y 
sudo apt-get install jenkins -y


------------------------------------------
# CentOs steps:
sudo yum update
sudo yum install java-devel -y
java --version
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo nano /etc/yum.repos.d/jenkins.repo
[jenkins]
name=Jenkins-stable
baseurl=http://pkg.jenkins.io/redhat
gpgcheck=1
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload

http://localhost:8080
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

https://phoenixnap.com/kb/how-to-install-jenkins-on-centos-8



