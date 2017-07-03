#import base image
FROM mysql:latest

#create working directory
RUN mkdir /fixtures
WORKDIR /fixtures

#copy files to /fixtures
COPY . /fixtures

#grant execution rights
RUN chmod +x /fixtures/setup.sh

#run the bash script
RUN /fixtures/setup.sh