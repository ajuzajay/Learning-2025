# Learning-2025

 **This is my first day for my bootcamp.**


    **Running the flask application locally in my laptop and then i will push the docker and aws ecr repo.**

**    step1: Create Environment for python application using the below commands.**

python3 -m venv <name of the venv> like bootcamp

source bootcamp/bin/activate

why we are creating virtual environment for python. ?

If you want to run mutiple application with multiple dependencies and you don't want install all dependencies in single machine, you can build a virtual enviornment for the application, In virtual environment, if you activate environment then only the dependencies for that particaular small spaces is available.

**Install app dependencies for python application**

pip install -r requirements.txt

Once python application dependencies Installed then we can run the application locally.

python app.py

-> access the app on localhost(127.0.0.1) on port 5000

**Build a docker image and run it**

1. Write a Dockerfile

2. Build a image and run the container (use the platform option for cross platform, i.e if you building the image on windows and running it on linux, and so on)


# docker build from the path local to dockerfile

docker build -t flask .  

 flask is tag name for building the image and (.) pointing and finding Docker file to build the image with that instrucation which is given in the docker file.


## platform compatibility along with repo name

Platform compatibility means if you are building a image in macbook that image won't support for Linx machine becuase of platform compatibility issues. In real world we will not use mac images we build image for Linux. like below

docker build -t ajayjohn100/bootcampday1 --platform=linux/amd64 .  <--- ajayjohn=<docker name> and which repo we are pushing that is <bootcampday1>


**How to readuce build time ?**

If you check Docker file you can see first we are copying requrement.txt instead of full code becuase if we need to change the code. Dependencies not need to create it again and again its only need to create at the first time and incase next time if we change the code it will skip the dependencies sessions and its will check the code which chanaged and according to that change image will build with new features.

To push a image to docker hub.

1. First we need to create a repo in docker like <bootcampday1> 

2. login the docker using docker commands below

      docker login  <-- It will prompt you to enter your username and password.
3. 
docker build -t ajayjohn100/bootcampday1:v1 --platform=linux/amd64 .  <--- ajayjohn=<docker name> and which repo we are pushing that is <bootcampday1>

4. if we are not given proper repo name we can't push image to docker. for that we need to change name of the image using the below command 


docker tag <source image:tag> <dockerrepo.tag>

docker tag 123b3jcj32:v1 ajayjohn100/bootcampday1:v1 

5. now we can push the docker image

docker push ajayjohn100/bootcampday1:v1 

6. Then you can see the image in dockerhub.


how to push docker image into ECR.

1. First we need to install aws cli then only you can push image to ECR

aws configure  ---> aws creditional and secret key we need to pass.

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 816069150653.dkr.ecr.us-east-1.amazonaws.com

docker build -t flask_application .

docker tag flask_application:latest 816069150653.dkr.ecr.us-east-1.amazonaws.com/flask_application:latest

docker push 816069150653.dkr.ecr.us-east-1.amazonaws.com/flask_application:latest

0. if we need pull the image from aws ecr, we can do two ways first one we need configure aws cli with secrets and creditional and other way we can create a IAM user and create a role and attach the role to ec2 instance.

This is about day1.... Thanks










 













