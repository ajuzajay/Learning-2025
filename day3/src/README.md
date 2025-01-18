Day3

two tier application.

1. **    step1: Create Environment for python application using the below commands.**

python3 -m venv <name of the venv> like bootcamp

source bootcamp/bin/activate

Install dependencies

pip install -r requirements.txt

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


Now we are creating flask application into container and push the image into AWS ECR and deploy to EC2 instance using GitHub	action	workflow. And our database are running in aws RDS 


- [ ] Create ec2 instance and installed docker and open security port

             5000 —>for flask application any one can connect from outside world

             22 —> ssh login
    - [ ]  Create repo in AWS ECR then you can use In our GitHub action workflow

- [ ] Created postgres db in aws using free tier.

             RDS created in private.

             Created a security group for RDS and its only able to connect the ec2 instance.

              5432 —> Postgres	db connectivity and its ec2 instance only able to connect.


- [ ]  Github action work flow

name: Deploy to ec2

on:
  push:
    branches:
      - master
    paths:
      - day3/src/**
env:
  AWS_REGION: "us-east-1"
  AWS_EC2: "flask_app"
  ECR_REPO: "flask-app-repo"
  GIT_SHA: ${{ github.sha }}
  AWS_ACCOUNT_ID: "816069150653"

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Login to Amazon ECR
        run: |
          aws ecr get-login-password --region ${{ env.AWS_REGION }} | \
          docker login --username AWS --password-stdin ${{ env.AWS_ACCOUNT_ID }}.dkr.ecr.${{ env.AWS_REGION }}.amazonaws.com

      - name: Build Docker image
        run: |
          docker build -t ${{ env.AWS_ACCOUNT_ID }}.dkr.ecr.${{ env.AWS_REGION }}.amazonaws.com/${{ env.ECR_REPO }}:${{ env.GIT_SHA }} ./day3/src/
          docker push ${{ env.AWS_ACCOUNT_ID }}.dkr.ecr.${{ env.AWS_REGION }}.amazonaws.com/${{ env.ECR_REPO }}:${{ env.GIT_SHA }}
          
  deploy:
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Get Public IP and SHA
        run: |
          # Retrieves the EC2 instance's public IP and sets the SHA
          echo "EC2_PUBLIC_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${{ env.AWS_EC2 }}" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)" >> "$GITHUB_ENV"  
          echo "SHA: $GITHUB_SHA" # Output SHA for debugging and verification

      - name: Execute Remote SSH Commands using SSH Key
        uses: appleboy/ssh-action@v1.0.3
        with:
          host: ${{ env.EC2_PUBLIC_IP }}
          username: ec2-user
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          port: 22
          script: |
            # Cleans up existing containers and images
            echo "Cleaning up the VM"
            docker rm -f $(docker ps -aq)
            docker rmi -f $(docker images -q)
            
            # Logs in to ECR and runs the Docker container
            echo "Running container"
            aws ecr get-login-password --region ${{ env.AWS_REGION }} | docker login --username AWS --password-stdin ${{ env.AWS_ACCOUNT_ID }}.dkr.ecr.${{ env.AWS_REGION }}.amazonaws.com  
            docker run -td -p 5000:5000 ${{ env.AWS_ACCOUNT_ID }}.dkr.ecr.${{ env.AWS_REGION }}.amazonaws.com/${{ env.ECR_REPO }}:${{ env.GIT_SHA }}


Last we create a ALB and create security group inbount 80 and outbond 5000

Target group need to listen to 5000 port because our application is running on port 5000 and attack that machine 

	











     













     











     
























 












 










