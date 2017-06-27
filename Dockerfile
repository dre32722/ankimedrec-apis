#FROM ubuntu:16.04
# Ubuntu image is large
#
# In order to thin this down I decided to use
# alpine image - approx 73 MB versus 750 MB
FROM mhart/alpine-node:latest

#
# Update Ubuntu packages
#
#On Ubuntu 
#RUN apt-get update 

#
# On Alpine
RUN apk update

#
# Install and Verify version of Node.js and NPM
# 
# On Ubuntu 16:04
#RUN apt-get -y install nodejs
#RUN nodejs --version
#RUN apt-get -y install npm
#RUN npm --version
#
# On Alpine Image 

#RUN apk add nodejs

#
# Install and Verify version of MongoDB Server
# 
#RUN apt-get -y install mongodb
#RUN mongod --version
#RUN /etc/init.d/mongodb restart
# 
#
# Install and Verify version of git
# 
#RUN apt-get -y install git
#RUN git --version

#
# Create local user and home directory
#
#RUN useradd -ms /bin/bash apidev
RUN set -x ; \
 addgroup -g 82 -S apidev ; \
 adduser -u 82 -D -S -G apidev apidev && exit 0 ; exit 1

USER apidev
RUN mkdir /home/apidev/ankimedrec-apis
WORKDIR /home/apidev/ankimedrec-apis

# 
# Copy medrecapi files (cloned from git) into docker image
#
COPY . /home/apidev/ankimedrec-apis
#
# If you need npm, don't use a base tag
RUN npm install

#EXPOSE 3000 27017
EXPOSE 3000
CMD ["node", "app.js"]
#CMD ["find", "."]
#CMD ["/bin/ash"]
