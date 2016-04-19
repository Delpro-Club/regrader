# regrader
An ICPC-style programming contest system that works.

## Requirement

- Docker : [http://docs.docker.com/installation/](http://docs.docker.com/installation/)

- docker-enter : [https://github.com/jpetazzo/nsenter](https://github.com/jpetazzo/nsenter)

- docker-compose : [https://github.com/docker/compose/releases](https://github.com/docker/compose/releases)

## Build
To build this project do the following:

1. Open command line, clone this project with `git clone https://github.com/Delpro-Club/regrader.git`, and move to 
   project root directory, `cd regrader`
2. run `docker-compose up -d`
3. enter the grader container, run `docker-enter regrader_regrader_1`
4. go to regrader folder, run `cd /var/www/regrader`.
5. Execute run_grader.sh script, run `./run_grader.sh`
