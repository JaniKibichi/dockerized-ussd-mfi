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
- First, create a config.php file in your root directory and fill in your Africa's Talking API credentials as below.

- You need to set up on the sandbox and [create](https://sandbox.africastalking.com/ussd/createchannel) a USSD channel that you will use to test by dialing into it via our [simulator](https://simulator.africastalking.com:1517/).

- Assuming that you are doing your development on a localhost, you have to expose your application living in the webroot of your localshost to the internet via a tunneling application like [Ngrok](https://ngrok.com/). Otherwise, if your server has a public IP, you are good to go! Your URL callback for this demo will become:
 http://<your ip address>/MfUSSD/microfinanceUSSD.php

- This application has been developed on an Ubuntu 16.04LTS and lives in the web root at /var/www/html/MfUSSD. Courtesy of Ngrok, the publicly accessible url is: https://b11cd817.ngrok.io (instead of http://localhost) which is referenced in the code as well. 
(Create your own which will be different.)

- The webhook or callback to this application therefore becomes: 
https://b11cd817.ngrok.io/MfUSSD/microfinanceUSSD.php. 
To allow the application to talk to the Africa's Talking USSD gateway, this callback URL is placed in the dashboard, [under ussd callbacks here](https://account.africastalking.com/ussd/callback).

- Finally, this application works with a connection to a MYSQL database. Create a database with a name, username and password of your choice. Also create a session_levels table and a users table. These details are configured in the dbConnector.php and this is required in the main application script microfinanceUSSD.php.

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