#Choose base image
FROM ubuntu:16.04

#Update base image
RUN apt-get update

#Install hhvm
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update && apt-get -y install hhvm && apt-get -y install nano && apt-get -y install cron

#fire up crontab
RUN service cron start
RUN touch mysql-cron
RUN echo "* * * * * /usr/bin/hhvm /ussd/crontab.php" >> mysql-cron
RUN mv mysql-cron /etc/cron.d/ 
RUN crontab /etc/cron.d/mysql-cron

#Install composer for other way to manage db later

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
RUN sed -i -e '$ahhvm.log.file = /var/log/hhvm/hhvm.log' /etc/hhvm/server.ini



