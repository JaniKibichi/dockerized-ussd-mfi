# A Docker USSD Service for MicroFinance Institutions
#### This App is now Dockerized

- Setting up the logic for USSD is easy with the [Africa's Talking API](docs.africastalking.com/ussd). This is a guide to how to use the code provided on this [repository](https://github.com/JaniKibichi/microfinance-ussd-app) to create a USSD that allows users to get registered and then access a menu of the following services:

| USSD APP Features                            |
| --------------------------------------------:| 
| Request to get a call from support           | 
| Deposit Money to user's account              |   
| Withdraw money from users account            |   
| Send money from users account to another     |   
| Repay loan                                   |   
| Buy Airtime                                  |  

## Prerequisites
#### Build The Image
- From: `https://github.com/JaniKibichi/dockerized-ussd-mfi`
- Build the image yourname/yourimagename by executing  the following command on the docker-playsms folder:
	`docker build -t yourname/yourimagename .`
- Push your new image to the docker hub:
	`docker push yourname/yourimagename`

#### Using the Image
- Either -> Pull/download your image from docker hub:
	`docker pull yourUsername/yourImage`
- Or -> Pull/download my image from docker hub:
	`docker pull grahamingokho/ussdafricastalking`
- Run this for installation, just the first time:
	`docker-compose run -d`
	`--name ussdmfi `
	`-e AT_APIKEY=yourAPIKey `
	`-e AT_USERNAME=yourUserName `
	`-e AT_SMSCODE=yourShortCode `
	`-e AT_NUMBER=yourVirtualNumber `
	`-e AT_PRODUCTNAME=yourMpesaProduct `
	`-p 6500:6500 `

- Get `<CONTAINER_ID>` of your image:
	`docker ps -l`
- Follow logs:
	`docker logs -f <CONTAINER_ID>`


## Callback URLs
#### Please note that some services will not work on the sandbox unless you edit `microfinanceUSSD.php`
###### (Everything works on the live account.)

- You need to set up on the sandbox and [create](https://sandbox.africastalking.com/ussd/createchannel) a USSD channel that you will use to test by dialing into it via our [simulator](https://simulator.africastalking.com:1517/).

- Assuming that you are doing your development on a localhost, you have to expose your application living in the webroot of your localshost to the internet via a tunneling application like [Ngrok](https://ngrok.com/). Otherwise, if your server has a public IP, you are good to go! Your URL callback for this demo will become:
 `http://<your ip address>:6500/microfinanceUSSD.php`


- Finally, this application works with a connection to a MYSQL database. 

## The Database
#### This is a service on docker-compose

mysql> describe microfinance;

| Field         | Type                         | Null  | Key | Default           | Extra                       |
| ------------- |:----------------------------:| -----:|----:| -----------------:| ---------------------------:|
| id            | int(6)                       |   YES |     | NULL              |                             |
| name          | varchar(30)                  |   YES |     | NULL              |                             |
| phonenumber   | varchar(20)                  |   YES |     | NULL              |                             |
| city          | varchar(30)                  |   YES |     | NULL              |                             |
| validation    | varchar(30)                  |   YES |     | NULL              |                             |
| reg_date      | timestamp                    |   NO  |     | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

6 rows in set (0.02 sec)

mysql> describe session_levels;

| Field         | Type                         | Null  | Key | Default | Extra |
| ------------- |:----------------------------:| -----:|----:| -------:| -----:|
| session_id    | varchar(50)                  |   YES |     | NULL    |       |
| phonenumber   | varchar(25)                  |   YES |     | NULL    |       |
| level         | tinyint(1)                   |   YES |     | NULL    |       |

3 rows in set (0.02 sec)

mysql> describe account;

| Field         | Type                         | Null  | Key | Default           | Extra                       |
| ------------- |:----------------------------:| -----:|----:| -----------------:| ---------------------------:|
| id            | int(6) unsigned              |   YES |     | NULL              |                             |
| phonenumber   | varchar(20)                  |   YES |     | NULL              |                             |
| balance       | double(5,2) unsigned zerofill|   YES |     | NULL              |                             |
| loan          | double(5,2) unsigned zerofill|   YES |     | NULL              |                             |
| reg_date      | timestamp                    |   NO  |     | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

5 rows in set (0.00 sec)

mysql> describe checkout;

| Field         | Type                         | Null  | Key | Default           | Extra                       |
| ------------- |:----------------------------:| -----:|----:| -----------------:| ---------------------------:|
| id            | int(6) unsigned              |   YES |     | NULL              |                             |
| status        | varchar(30)                  |   YES |     | NULL              |                             |
| phoneNumber   | varchar(30)                  |   YES |     | NULL              |                             |
| amount        | int(11)                      |   YES |     | NULL              |                             |
| reg_date      | timestamp                    |   NO  |     | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

5 rows in set (0.00 sec)

## Features on the Services List
This USSD application has the following user journey.

- The user dials the ussd code - something like `*384*303#`

- The application checks if the user is registered or not. If the user is registered, the services menu is served which allows the user to: receive SMS, receive a call with an IVR menu.

- In case the user is not registered, the application prompts the user for their name and city (with validations), before successfully serving the services menu.

- That is basically our application! Happy coding!