FROM nginx:1.17

USER root

MAINTAINER u848379

RUN mkdir -p /etc/nginx/certs

RUN mkdir -p /var/www/html

COPY /NGINX/default.conf /etc/nginx/conf.d/default.conf

COPY /SSL/tls/my-service.crt /etc/nginx/certs/server.crt

COPY /SSL/tls/my-service.key /etc/nginx/certs/server.key

COPY /SSL/tls/ca.crt /etc/nginx/certs/ca.crt

RUN echo “The Nginx Web Server is Running” > /var/www/html/index.html

# OpenShift Running as non-root, have to do a few changes

# Give NGINX directory permissions to root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx

# Comment out the NGINX user decalration
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf

# 443 Not allowed as a non-root user
EXPOSE 8080
