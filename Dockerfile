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