

CREATE TABLE session_levels (
    session_id varchar(50),
    phone_number varchar(25),
    level tinyint(1)
);

CREATE TABLE microfinance(
  id  int(6) NOT NULL,
  name varchar(30),
  phonenumber varchar(20), 
  city varchar(30),
  validation varchar(30),
  reg_date timestamp DEFAULT CURRENT_TIMESTAMP,   
  PRIMARY KEY (id)
);

CREATE TABLE account(
  id  int(6) NOT NULL,
  phonenumber varchar(20), 
  balance double(5,2) unsigned zerofill,
  loan double(5,2) unsigned zerofill,  
  reg_date timestamp DEFAULT CURRENT_TIMESTAMP,   
  PRIMARY KEY (id)
);

CREATE TABLE checkout(
  id  int(6) NOT NULL,
  phonenumber varchar(20), 
  status varchar(30),   
  amount int(11);
  reg_date timestamp DEFAULT CURRENT_TIMESTAMP,   
  PRIMARY KEY (id)
);

