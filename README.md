**Create a Dockerfile with**

\# pull official base image

\# need to update to a newer version to fix a build bug

FROM node:18-alpine



\# set working directory

\# working directory of lastname\_firstname\_site as requested

WORKDIR /peters\_seth\_site



\# install app dependencies

COPY package.json ./

RUN npm install



\# add app. Copy from here to container

COPY . ./



\# claim port 7775

EXPOSE 7775



\# start app

CMD \["npm", "start"]



**Create a .dockerignore file with**

node\_modules

build

.dockerignore

Dockerfile

Dockerfile.prod





**Use to build the create react app. -t means tag and what comes after it is the name. The period grabs the files in the current directory**

docker build -t peters\_seth\_coding\_assignment11 .

**Use this to run the container**

docker run -it --rm -p 7775:3000 --name peters\_seth\_coding\_assignment11 peters\_seth\_coding\_assignment11



**-it** is interactive mode and the website said it is required

**--rm** removes the container when it is stopped. I kept it because I didn't want to keep deleting containers to test

**-p** port forwards. It ports to the local of 7775 and grabs from 3000 (It kept saying to look at port 3000 so I think that's what that means)

**--name** names the container 

and then the last one is the image it runs from

