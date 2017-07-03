#Choose base image
FROM ubuntu:16.04

#environment variables
ENV AT_APIKEY=yourapikey AT_USERNAME=yourapiusername \
    AT_NUMBER=youratnumber AT_SMSCODE=yoursmscode AT_PRODUCTNAME=yourproductname

#Update base image
RUN apt-get update

#Install hhvm
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update && apt-get -y install hhvm && apt-get -y install nano

#Install composer

#Create working directory
RUN mkdir /ussd
WORKDIR /ussd

#Copy ussd app
COPY . /ussd

#Create a logs file for hhvm
RUN cd && mkdir /var/log/hhvm
RUN touch /var/log/hhvm/hhvm.log

#Make changes to the file hhvm.log
RUN sed -i -e 's/hhvm.log.use_log_file = false/hhvm.log.use_log_file = true/g' /etc/hhvm/server.ini
RUN sed '/hhvm.log.use_log_file = true/ a hhvm.log.file = /var/log/hhvm/hhvm.log' /etc/hhvm/server.ini
