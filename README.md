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
2. Run `docker-compose up -d`
3. Inspect mysql Database IP by run `docker inspect regrader_db_1 | grep IPAddress`
4. Set the IP that you get into DB_HOSTNAME field in .env file
5. enter the grader container, run `docker-enter regrader_regrader_1`
6. go to regrader folder, run `cd /var/www/regrader`.
7. Execute run_grader.sh script, run `./run_grader.sh`

## Common Error
- If you get error "field 'X' doesn't have a default value". Most likely the database is in Strict Mode. To solve this, run
  `SET GLOBAL sql_mode=''` and `FLUSH PRIVILEGES` on your mysql server.

## Notes
- Don't forget to change your DB root password. You can change the password in `docker-compose.yml` file
- Don't forget to change your admin password in Regrader site, the default is username : admin, password : admin
