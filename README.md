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