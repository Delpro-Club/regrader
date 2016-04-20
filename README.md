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
3. Inspect **db container** to find the IP, run `docker inspect regrader_db_1 | grep IPAddress`
4. Set the IP that you get into **DB_HOSTNAME** field in .env file
5. enter the grader container, run `docker-enter regrader_regrader_1`
6. go to regrader folder, run `cd /var/www/regrader`.
7. Execute run_grader.sh script, run `./run_grader.sh`

## Common Error
- If you get error **"field 'X' doesn't have a default value"**. Most likely the database is in Strict Mode. To solve this, first enter the db container, run `docker-enter regrader_db_1`. Enter the mysql server, the default command is `mysql -u root -proot`. Change the -p as your root password. Then run mysql command`SET GLOBAL sql_mode=''` and `FLUSH PRIVILEGES` on your mysql server.

## Notes
- Don't forget to change your DB root password. You can change the password in `docker-compose.yml` file
- Don't forget to change your admin password in Regrader site, the default is username : admin, password : admin
- Building the image will take a huge of bandwidth. I'm suggest to get a wifi connection

Configuring the System
----------------------

#### 1. Change admin password

Open **Manage**->**Users**. Edit admin user and change the password to something else.

#### 2. Configure programming languages

Open **Manage**->**Languages**. There will be 4 programming languages set up by default: Pascal, Java, C++, and C. For each language you want to actually use, you have to at least edit its compile command as necessary depending where you install the compiler.

#### 3. Configure additional options

Open **Manage**->**Options** and configure additional properties of the system.

- **Website, Top, & Bottom Names**
To be shown in the header.
- **Left, Right 1, Right 2 Logo Filenames**
To be shown in the header. If set, the logo files must be uploaded in **Manage**->**Files**.
- **Items per Page**
The number of rows in a table. Used in the list of users, problems, submissions, etc.

Using the System
------------------

After installation, you can log in and add users, contests, problems, etc. The interface should be quite intuitive to use :)

Miscellaneous
-------------

#### Solution checker

You can set up a solution checker for your problems. This is useful for problems that can have multiple solutions. The template for a checker can be found here: https://github.com/fushar/regrader/blob/develop/examples/checker.cpp.

#### Internationalization

Regrader currently supports English and Indonesian. To change the language to Indonesian, open **application/config/config.php** and change the value of **$config['language']** into **'indonesian'**.

#### Institution logos

You can show institution logos beside the contestant names in the scoreboard. The scoreboard will look very nice. Just upload **X**.jpg in **Manage->Files** as the logo for institution **X**. Then, tick the option **Show Institution Logos** in the corresponding contest's setting.

#### Public files

You can use **Manage**->**Files** to upload public files, for example, for inserting images in problem statements.

#### Public raw scoreboard

Besides the usual public scoreboard, you can also generate public scoreboard that is separated from the system. This is useful for hiding the contest URL address from the public and in order to minimize traffic and external attack.

- Download the public raw scoreboard HTML file from the admin scoreboard menu.
- Copy the **assets/** directory.
- Publish both in a separate address.

Of course, to achieve a semi-live scoreboard, you have to do the above steps periodically, possibly using a script.
