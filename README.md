**Open Docker**



**First create a directory where the React files should go**

**Open up the command prompt and go to the directory just created**





**Use the following to create the create react app files in the directory location currently within**

npx create-react-app peters_seth_site

**Update yaml**
npm install yaml@2.9.0

**Edit src/App.js**

Add <h1>Codin 1</h1>



**Create a Dockerfile with the following in the new peters_seth_site directory**

#build environment
#Base Image as 18 to avoid errors
FROM node:18-alpine as build
#WORKDIR to what was it was asked to be
WORKDIR /peters_seth_site
#signify where to put the node modules when installing them
ENV PATH /peters_seth_site/node_modules/.bin:$PATH
#install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install react-scripts@3.4.1 -g
RUN npm ci
#add app. Copy from here to container
COPY . ./
#Build the project environment
RUN npm run build

#production environment
#Set Base image for production environment
FROM nginx:stable-alpine
#Copy from the build environment -- The path to the build -- the path to where nginx docker image looks to grab files from to serve
#to the browser
COPY --from=build /peters_seth_site/build /usr/share/nginx/html
#Claim the port 80 to be listened to
EXPOSE 80
#Use nginx -- use the instructions taken from the command line -- tell nginx to stay in foreground and not background itself
#basically it will run the container which uses and image built from this dockerfile. When we run the container it makes a build
#that we grab the website files from then we send it to where it needs to befor nginx to find it so it can be grabbed
CMD ["nginx", "-g", "daemon off;"]


**Create a .dockerignore file with the following: (This will reduce the time to build the image)**

node_modules

build

.dockerignore

Dockerfile

Dockerfile.prod





**Use to build the create react app from the peters_seth_site directory.**

**-t means tag and what comes after it is the name. The period grabs the files in the current directory**

docker build -t peters_seth_coding_assignment11 .

**Use this to run the container**

docker run -it --rm -p 7775:80 --name peters_seth_coding_assignment11 peters_seth_coding_assignment11



**-it** is interactive mode and the website said it is required

**--rm** removes the container when it is stopped. I kept it because I didn't want to keep deleting containers to test

**-p** port forwards. It ports to the local of 7775 and grabs from 3000 (3000 being that the container is asking to grab from (listening from))

**--name** names the container

and then the last one is the image it runs from

