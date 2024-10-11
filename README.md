# PHP8.2

Docker image to execute / debug php projects

It generates 2 different images based on ubuntu 22.04, the main
version ready to production and the second one "-xdebug" that includes
the xcode 3 debugger integrated an configured for host debugging.

In order to xdebug be able to work with localhost the docker-compose file
have tu include this lines:

```
        extra_hosts:
            - "host.docker.internal:host-gateway"
```

Additional xcode configuration can be added to a file mounted
as volume on /etc/php/8.2/apache2/conf.d/docker-php-ext-xdebug.ini 

Client configuration should listen to port 9003.

## Usage

The website should be mounted/copied to /var/www/Website on the image

If you want to generate a production image including the contents
your Dockerfile should look like this:

```
FROM yoprogramo/php8.2:1.0.0

COPY web /var/www/Website

WORKDIR /var/www/Website
CMD /usr/sbin/apache2ctl -D FOREGROUND
```

If you want to use external directory mounted on your docker-compose
the file should look like this:

```
services:
  php:
    image: yoprogramo/php8.2:1.0.0
    volumes:
        - ./web:/var/www/Website
    ports:
        - 8080:80
```

and then the website will be accesible on http://localhost:8080

## debugging

In this case you should use the -xdebug version and configure
the client to listen to port 9003 and map the path to your
sources directory. If you use visual studio code, use the
PHP Debug extension and add this configuration to launch.json
(it presumes that you have the web files under web directory):

```
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/var/www/Website/": "${workspaceFolder}/web"
            }
        },
```
Then you can put some breakpoint and load the page to check that
the execution stops in this point.