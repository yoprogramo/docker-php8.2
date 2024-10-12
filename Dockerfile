FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
# Install basics
RUN apt update
RUN apt-get update
RUN apt-get install -y software-properties-common 
RUN add-apt-repository ppa:ondrej/php 
RUN add-apt-repository ppa:ondrej/apache2
RUN apt-get update
RUN apt-get install -y --force-yes curl
# Install PHP (latest) 
RUN apt-get install -y --allow-unauthenticated php8.2 php8.2-mysql php8.2-cli php8.2-gd php8.2-curl php8.2-mbstring php8.2-dom php8.2-imagick php8.2-zip php8.2-intl
# Enable apache mods.
RUN a2enmod php8.2
RUN a2enmod rewrite
# Update the PHP.ini file.
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/8.2/apache2/php.ini
# Manually set up the apache environment variables
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
# Expose apache.
EXPOSE 80
EXPOSE 443

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf
ADD php.ini /etc/php/8.2/apache2/php.ini

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND
