# Dockerfile

FROM debian:bullseye

# Create the necessary directories
# RUN mkdir -p /etc/nginx

# Install NGINX and openSSL
RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -m 755 -p /etc/nginx/ssl
# Generate a self-signed SSL certificate (for testing purposes)
RUN openssl req -x509 -nodes -newkey rsa:2048 \
-keyout /etc/nginx/private.key \
-out /etc/nginx/public.crt \
-subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${DB_USER}"

# Expose the HTTPS port
# EXPOSE 443

# Run as non-root?
# See https://www.geeksforgeeks.org/how-to-run-nginx-for-root-non-root/
#RUN useradd -ms /bin/bash -G www-data nginx
#RUN mkdir -p /var/log/nginx && chown -R nginx:nginx /var/log/nginx /etc/nginx /var/lib/nginx /var/run/nginx.pid???
#USER nginx

# Configure NGINX to use TLSv1.3 only
COPY conf/nginx.conf /etc/nginx/nginx.conf

# RUN chmod 755 /var/www/html
# RUN chown -R www-data:www-data /var/www/html

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
