# run db locally
docker run --name flask_postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=password -e POSTGRES_DB=postgres -p 5432:5432 -d postgres

# version 14 of postgres
docker run --name flask_postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=password -e POSTGRES_DB=postgres -p 5432:5432 -d postgres:14
# psql command tpo connect to postgres db
psql -h <host> -d <db-name> -U <username> -W
 

# migrate the db
flask db init   
flask db migrate -m "Initial migration."
flask db upgrade




# run the app with docker

docker build -t flask-app .
docker run -p 5000:5000 flask-app


# psql 

$ docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres


ajayjohn@ajays-MacBook-Air Learning-2025 % docker run --name flask_postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=password -e POSTGRES_DB=postgres -p 5432:5432 -d postgres:14.  …….—>POSTGRES_DB=postgres --> database name 


Day3

two tier application.

1. **    step1: Create Environment for python application using the below commands.**

python3 -m venv <name of the venv> like bootcamp

source bootcamp/bin/activate

2. First we need to create the database using container.

docker run --name flask_postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=password -e POSTGRES_DB=postgres -p 5432:5432 -d postgres:14

3.Then we need to run the app locally 

python app.py

* How we can connect postgres db with my MacBook.

Just install Postgres using the below commands 

brew install postgresql@14 —>14 its version

After postgres installation in Mac to connect the postgres db using cli command

psql -h localhost -p 5432 -U postgres -d postgres   —> U=database username, last postgres —> database name

psql -h  -p 5432 -U postgres -d mydb

Flask application default port is 5000

You can see the application is running on the local host then you can add some data and query the data which we added in data base how we can check using cli 

Login database 

psql -h localhost -p 5432 -U postgres -d postgres 

postgres=# select current_database();
 current_database 
------------------
 postgres
(1 row)



4.Now we are going to run both application in docker-compose container.

docker-compose up --build

5. we are creating postgres database in aws rds. and connecting the db from our local flask application

aws postgres db connecting using psql cli commands.

psql -h flask-db.czysgeo0icaa.us-east-1.rds.amazonaws.com -p 5432 -U postgres -d mydb

6. while creating database we are opened this port in aws security group 

Tcp 5000 0.0.0.0

All traffic All

Tcp 80

postgres 5432

mysql/Arora 3366

ssh 22 



















 












 










