##Install in Amazon Ubuntu:wq!

sudo usermod -aG docker $USER
docker pull docker.bintray.io/jfrog/artifactory-oss:latest
sudo mkdir -p /jfrog/artifactory
sudo chown -R 1030 /jfrog/
docker run --name artifactory -d -p 8081:8081 -p 8082:8082 -v /jfrog/artifactory:/var/opt/jfrog/artifactory docker.bintray.io/jfrog/artifactory-oss:latest

##
mkdir -p $JFROG_HOME/artifactory/var/etc/
cd $JFROG_HOME/artifactory/var/etc/
touch ./system.yaml
sudo chown -R 1030:1030 $JFROG_HOME/artifactory/var
sudo chmod -R 777 $JFROG_HOME/artifactory/var
# External database
docker run --name postgres -itd -e POSTGRES_USER=artifactory -e POSTGRES_PASSWORD=password -e POSTGRES_DB=artifactorydb -p 5432:5432 library/postgres

#configure sstem.yaml

shared:
  database:
  driver: org.postgresql.Driver
  type: postgresql
  url: jdbc:postgresql://host.docker.internal:5432/artifactorydb
  username: artifactory
  password: password

#Note: The database connection URL may vary depending on the Container Engine in use. Please ensure you are using the correct URL for your specific environment.

#Customize the product configuration (optional) including Java Opts, and filestore.

Note
For Podman installations, verify that the host's ID 
shared.node.id
 and IP 
 shared.node.ip
  are added to the 
  system.yaml
  .

  If these are not manually added, they are automatically resolved as the container's IP, meaning other nodes and services will not be able to reach this instance.

# Start the Artifactory container using the process that is relevant for your system.
docker run --name artifactory -v $JFROG_HOME/artifactory/var/:/var/opt/jfrog/artifactory -d -p 8081:8081 -p 8082:8082 releases-docker.jfrog.io/jfrog/artifactory-pro:<version>
For installation of Artifactory Open Source, replace the Container Image with 
artifactory-oss
.

For installation of Artifactory Community Edition for C/C++, replace the Container Image with 
artifactory-cpp-ce .

#Manage Artifactory using native Docker commands.

docker ps
docker stop artifactory
⧉
Access Artifactory from your browser at: 
http://SERVER_HOSTNAME:8082/ui/

For example, on your local machine: 
http://localhost:8082/ui/

Check the Artifactory log.

docker logs -f artifactory
⧉
Configure log rotation of the console log
The 
console.log
 file can grow quickly since all services write to it. For more information, see configure the log rotation.

 Redhat UBI Micro base image
 In an effort to provide a more secure Artifactory image, Artifactory now uses the Redhat UBI Micro base image. Some of the tools that were available in the Artifactory image are not available in this more secure image. For more information, see JFrog Products Container Base Image.

 Artifactory Post-Installation Steps
 Once Artifactory is installed, complete the following tasks:

 Change the default admin password.

 The default user will have the following credentials predefined in the system:

 User: admin

 Password: password

 Make sure you have applied your licenses.

 Continue to configure the system using the Artifactory Product Configuration.

 Configure a reverse proxy (optional for Docker Registry).

 Run Artifactory as a front end of each node using one of the supported HTTP servers.



