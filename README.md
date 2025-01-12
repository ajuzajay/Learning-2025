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

docker build -t ajuzajay/Learning-2025:v2 --platform=linux/amd64 .















