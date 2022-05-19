### Docker container for Drupal 9+ w/php 8.1 & apache 2.4.51

Pulls from [official php Docker Hub](https://hub.docker.com/_/php)

## Build
```sh
docker build -t ${USER}/php-apache .
```

## Run
```sh
docker run --rm -d -p 80:80 --name websrv ${USER}/php-apache:latest
```
