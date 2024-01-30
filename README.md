### Inception

## Dockerfile for nginx
    
**FROM** debian:buster
    
    This line specifies the base image for the new image. In this case, it starts with a Debian Linux image based on the "buster" version.
**RUN** apt-get update && apt-get install -y nginx openssl
    
    This line runs the specified commands in the shell during the image build process. It updates the package lists and installs the NGINX web server and OpenSSL.
**RUN** openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/nginx/private.key -out /etc/nginx/public.crt -subj "/CN=localhost" -days 3650
    
    This line generates a self-signed SSL certificate for testing purposes. The openssl req command is used to create a certificate signing request. The options -x509 indicate that a self-signed certificate is desired, and -subj "/CN=localhost" sets the common name (CN) to "localhost." The private key is saved in /etc/nginx/private.key, and the public certificate is saved in /etc/nginx/public.crt.
**RUN** sed -i '/ssl_protocols/c\ssl_protocols TLSv1.3;' /etc/nginx/nginx.conf
    
    This line uses the sed command to replace the line in the NGINX configuration file (/etc/nginx/nginx.conf) that specifies the SSL protocols. It sets the SSL protocols to only use TLSv1.3.
**EXPOSE** 443
    
    This line informs Docker that the container will listen on port 443 at runtime. It doesn't actually publish the port; it's more of a documentation feature. The actual port binding is done when running the container.
**CMD** ["nginx", "-g", "daemon off;"]
    
    This line sets the default command to run when the container starts. It starts the NGINX web server and runs it in the foreground with the specified options (-g "daemon off;" keeps NGINX in the foreground instead of running as a background daemon). This command is executed when the container is started based on the built image.

    
## some of useful docker  commands

* **docker build** 

    Meaning: Builds a Docker image from a specified Dockerfile. The Dockerfile contains instructions on how to assemble the image, including the base image, application code, dependencies, and configurations.
* **docker up -d** 

    Starts Docker containers defined in a docker-compose.yml file in detached mode (runs in the background).
* **docker exec -it <container-id> /bin/sh** 

    (Meaning: Executes a command in a running container. In this case, it starts an interactive shell (/bin/sh) within the specified container.)
* **docker ps** (Meaning: Lists all running containers.)
* **docker images** (Meaning: Lists all locally available Docker images.)
* **docker stop container-id** (Stops a running container.)
* **docker rm my_container** (Meaning: Removes a stopped container.)
* **docker rmi my_image:latest** (Meaning: Removes a Docker image.)
* **docker network ls** (Meaning: Lists all Docker networks.)
* **docker-compose down -v** (Meaning: to down the container and remove all volume)
* **docker-compose down** (Meaning: Stop and remove the containers)
* **docker compose build --no-cache**
* **ps aux | grep mysqld** (meaning check if the MariaDB process is running)


## necessary links

* [nginx.conf](https://www.nginx.com/resources/wiki/start/topics/examples/full/)
* [wp.conf](https://gist.github.com/lidaobing/673798)
* [wp-config-docker.php](https://github.com/WordPress/WordPress/blob/master/wp-config-sample.php)
* [wp Dockerfile](https://www.datanovia.com/en/lessons/wordpress-docker-setup-files-example-for-local-development/)
* [wp docker-compose](https://github.com/docker/awesome-compose/tree/master/official-documentation-samples/wordpress/)
* [.env](https://www.datanovia.com/en/lessons/wordpress-docker-setup-files-example-for-local-development/)


docker stop $(docker ps -qa); docker rm $(docker ps -qa); 

docker rmi -f $(docker images -qa); 

docker volume rm $(docker volume ls -q);

docker network rm $(docker network ls -q) 2> /dev/null

to start mariadb

**mysql -u root -p**

**SHOW TABLES FROM <DB_NAME>;**

**USE <DB_NAME>;**(to connecte to the correct database.)

**SHOW DATABASES;**

**SHOW GRANTS;**(Verify that the user you are using to connect to the database has the necessary permissions to view tables in the wordpressdb database.)

**SHOW TABLES;**(to see you your database tables created)

##to start and check mariadb

docker exec -it mariadb service mysql start

docker exec -it mariadb service mysqld status

service name might be different inside your MariaDB container. To check the status and start the service,

docker exec -it mariadb ps aux | grep mysqld

to mount volume

docker volume create <volume_name>

docker volume create <volume_name>
