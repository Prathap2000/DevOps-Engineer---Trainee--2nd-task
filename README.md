Elasticsearch Setup with Docker and Security Configuration
This guide explains how to set up an Elasticsearch cluster with Docker, enable security features, and set up passwords for reserved users.

Prerequisites:
Docker installed on your machine
A terminal/command line interface
Step 1: Pull Elasticsearch Docker Image
First, ensure you have the Elasticsearch Docker image pulled.

docker pull docker.elastic.co/elasticsearch/elasticsearch:8.5.3
This pulls the specific version (8.5.3) of Elasticsearch.

Step 2: Run Elasticsearch Container with Security Settings
Run the Elasticsearch container with security enabled (Basic Authentication, TLS/SSL).

docker run -d \
  -e "discovery.type=single-node" \
  -e "xpack.security.enabled=true" \
  -e "xpack.security.transport.ssl.enabled=true" \
  -p 9200:9200 -p 9300:9300 \
  --name elasticsearch-node1 \
  docker.elastic.co/elasticsearch/elasticsearch:8.5.3
discovery.type=single-node: Configures the node as a single-node cluster.
xpack.security.enabled=true: Enables security features like authentication and encryption.
xpack.security.transport.ssl.enabled=true: Enables transport layer encryption (SSL/TLS).
Step 3: Check the Running Containers
After starting the container, you can check its status using the following command:

docker ps
If the container is running successfully, you will see elasticsearch-node1 listed as an active container.

Step 4: Access the Container and Set Passwords
To configure the passwords for the reserved users, you need to access the running Elasticsearch container:

docker exec -it elasticsearch-node1 /bin/bash
Once inside the container, use the following command to set the passwords for the reserved users:

bin/elasticsearch-setup-passwords interactive
You will be prompted to enter new passwords for the following users:

elastic
apm_system
kibana_system
logstash_system
beats_system
remote_monitoring_user
Make sure the passwords are at least 6 characters long.

Step 5: Verify the Password Changes
Once the passwords are set, the system will confirm that the passwords for the users have been changed.

You can test the elastic user login by running the following command from your terminal (outside the container):

curl -u elastic:your_password_here http://localhost:9200
Replace your_password_here with the password you set for the elastic user.

Step 6: Access Elasticsearch via Kibana (Optional)
If you plan to use Kibana, ensure that Kibana is configured to connect to Elasticsearch using the same elastic credentials.

Step 7: Stop and Remove the Elasticsearch Container (Optional)
If you need to stop or remove the container, you can do so with the following commands:

docker stop elasticsearch-node1
docker rm elasticsearch-node1
Notes:
The elasticsearch-setup-passwords tool has been deprecated and will be removed in future releases.
Always ensure your passwords are securely stored.
By default, Elasticsearch will only be accessible on localhost (port 9200). To make it accessible externally, additional configuration may be needed (e.g., modifying network settings or firewall rules).
