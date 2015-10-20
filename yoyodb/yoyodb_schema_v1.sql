DROP TABLE GroupCustomers;
DROP TABLE Groups;
DROP TABLE Tourguides;
DROP TABLE Customers;
DROP TABLE Users;
DROP TABLE People;

-- people table stores universal information about any person
CREATE TABLE People (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name			varchar(50),
  last_name			varchar(50),
  gender			char(1),
  birth_date			date,
  creation_time			timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
INSERT INTO People (first_name,last_name,gender,birth_date)
  VALUES ("Heping","Zheng","M","1979-03-09");

-- user is whoever access the yoyodb database and contact, it can be either customer or tour guide
CREATE TABLE Users (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  person_id			INT(4) NOT NULL,
  login_email			varchar(50) NOT NULL,	-- Email also serve as a login ID, if customer insist to have no Email, a user-chosen login ID will be used in this field with @yoyous.com as the Email server
  login_password		char(32),		-- a field to store login credential by using MD5 encrytion			
-- BTW, the 32 digits MD5 encoded login_password will also be used as activation code sent to the user via EMail to verify the Email address
  activated			boolean DEFAULT FALSE,
  contact_phone_country		INT(2),
  contact_phone_number		INT(8),
  residence_street_address	varchar(50),
  residence_city		varchar(20),
  residence_state		varchar(20),
  residence_zipcode		varchar(20),
  residence_country		varchar(20),
  signup_time			timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (person_id) REFERENCES People(id)
) ENGINE=InnoDB;
INSERT INTO Users (person_id,login_email,login_password,activated,contact_phone_country,contact_phone_number,
                   residence_street_address,residence_city,residence_state,residence_zipcode,residence_country)
  VALUES (1,"dust.zheng@gmail.com",MD5("111111"),TRUE,1,4348255796,"94 London Ct","Ruckersville","VA","22968-3383","United States");

-- customer info, the customer may or may not be a group contact. If a customer is a group contact, the is_group_contact flag will be set to True, and yoyodb will require a record in users table
CREATE TABLE Customers (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  person_id			INT(4) NOT NULL,
  passport_number		char(9),
  passport_issue_city		varchar(20),
  passport_issue_country	varchar(20),
  passport_issue_date		date,
  passport_expire_date		date,
  visa_number			char(8),
  visa_control_number		char(14),
  visa_issue_city		varchar(20),
  visa_issue_country		varchar(20),
  visa_issue_date		date,
  visa_expire_date		date,
  FOREIGN KEY (person_id) REFERENCES People(id)
) ENGINE=InnoDB;

-- tour guide info, to fulfill the role of a tour guide, one must sign up into yoyodb, and have to be a user of yoyodb
CREATE TABLE Tourguides (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  person_id			INT(4) NOT NULL,
  user_id			INT(4) NOT NULL,
  driver_license_number		char(9),
  driver_license_issue_state	varchar(20),
  driver_licensed_age		INT(1),
  driver_license_expire_date	date,
  insurance_company		varchar(20),
  insurance_policy_number	varchar(20),
  insurance_effective_date	date,
  insurance_expire_date		date,
  credit_card_type		varchar(10),
  credit_card_number		INT(8),
  credit_card_expire_date	date,
  language_english		INT(1), -- language proficiency score (1-10) for english
  language_mandarin		INT(1), -- language proficiency score (1-10) for mandarin
  language_cantonese		INT(1), -- language proficiency score (1-10) for cantonese
  language_teochew		INT(1), -- language proficiency score (1-10) for teochew
  driver_rating			INT(1),	-- certified score (1-10) based on safe-drving experience and knowledge to reaching destination
  guide_rating			INT(1), -- certified score (1-10) based on personality, knowledge about desination, and ability to express
  yoyous_rating			INT(1), -- certified score (1-10) based on experience with yoyous operating platform
  yoyous_certificate_issue_date	date,
  yoyous_certificate_expire_date	date,
  number_of_tours_guided	INT(2) NOT NULL DEFAULT 0,
  customer_rating		INT(1) DEFAULT NULL, -- overall feedback rating (1-10) based on previous customer reviews
  last_tour_guided		date DEFAULT NULL,
  FOREIGN KEY (person_id) REFERENCES People(id),
  FOREIGN KEY (user_id) REFERENCES Users(id)
) ENGINE=InnoDB;
INSERT INTO Tourguides (person_id,user_id,driver_license_number,driver_license_issue_state,driver_licensed_age,driver_license_expire_date,
			insurance_company,insurance_policy_number,insurance_effective_date,insurance_expire_date,
			credit_card_type,credit_card_number,credit_card_expire_date,
			language_english,language_mandarin,language_cantonese,language_teochew,driver_rating,guide_rating,yoyous_rating,
			yoyous_certificate_issue_date,yoyous_certificate_expire_date)
  VALUES (1,1,"T61-22-6870","VA",22,"2017-03-09","GEICO","32681791","2014-09-06","2015-03-06",
          "VISA",4397078081486192,"2015-05-01",8,10,2,7,8,6,10,"2014-12-11","2024-12-10");

-- This table stores basic information for each group
CREATE TABLE Groups (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tourguide_id			INT(4) NOT NULL,
  contact_customer_id		INT(4) NOT NULL,
  group_size			integer,
  propose_date			date,
  assemble_date			date,
  disband_date			date,
  FOREIGN KEY (tourguide_id) REFERENCES Tourguides(id),
  FOREIGN KEY (contact_customer_id) REFERENCES Customers(id)
) ENGINE=InnoDB;

-- This is a junction table between group and customers, one group would be composed of multiple customers, yet one customer may be in multiple groups at different times
CREATE TABLE GroupCustomers (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  group_id			INT(4) NOT NULL,
  customer_id			INT(4) NOT NULL,
  is_kid			boolean,	-- is_kid flag is only set when the travller is underage at the time of traveling
  is_group_contact		boolean,	-- only an adult can be a group contact
  user_id			INT(4),		-- user_id is only mandatory if this customer is a group contact
  FOREIGN KEY (group_id) REFERENCES Groups(id),
  FOREIGN KEY (customer_id) REFERENCES Customers(id),
  FOREIGN KEY (user_id) REFERENCES Users(id)
) ENGINE=InnoDB;

CREATE TABLE Addresses (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  street_address		varchar(100),
  longitude			FLOAT,
  latitude			FLOAT,
) ENGINE=InnoDB;

-- Address for the  three following three tables are specific for each customer,
--   determined on the fly by priceline or other online booking agents
--   and are normally assigned by yoyous subject to convenience instead of suggested by the customer
CREATE TABLE Flights (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  groupcustomer_id		INT(4) NOT NULL,
  carrier			varchar(20),
  depart_airport_code		char(3),
  depart_time			datetime,
  arrive_airport_code		char(3),
  arrive_time			datetime,
  arrive_flight_number		varchar(10),
  return_airport_code		char(3),
  return_time			datetime,
  return_flight_number		varchar(10),
  FOREIGN KEY (groupcustomer_id) REFERENCES GroupCustomers(id)
) ENGINE=InnoDB;

CREATE TABLE Hotels (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
) ENGINE=InnoDB;

CREATE TABLE Cars (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
) ENGINE=InnoDB;

-- The three tables Attractions, Restaurants, Shoppings are for pre-stored information,
--   it is a semi-automated curated information from Tripadvisor and other traveler's knowledge websites,
--   or may be suggested by either the customer or the tourguide
CREATE TABLE Destinations (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  category			INT(1),	-- There are only three broad categories of destinations
  name				varchar(100),
) ENGINE=InnoDB;

CREATE TABLE Attractions (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  destination_id		INT(4) NOT NULL,
  FOREIGN KEY (destination_id) REFERENCES Destinations(id)
) ENGINE=InnoDB;

CREATE TABLE Shoppings (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  destination_id		INT(4) NOT NULL,
  FOREIGN KEY (destination_id) REFERENCES Destinations(id)
) ENGINE=InnoDB;

CREATE TABLE Restaurants (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  destination_id		INT(4) NOT NULL,
  FOREIGN KEY (destination_id) REFERENCES Destinations(id)
) ENGINE=InnoDB;

-- Planners, Shoppers, and Accountants are the three wizards for yoyous customers
-- Planners and Shoppers are used before the trip, to request the information about the 
-- Accountants is the 3rd wizard used during and after the trip for the customer to control the expenses in real time

CREATE TABLE PersonalPlanners (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
) ENGINE=InnoDB;

CREATE TABLE PersonalShoppers (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
) ENGINE=InnoDB;

CREATE TABLE PersonalAccountants (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
) ENGINE=InnoDB;

CREATE TABLE Offers (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_user_id		INT(4) NOT NULL,
  tourguide_user_id		INT(4) NOT NULL, -- Default to the first tourguide in the list for initial offer
  offer_type			INT(1),	-- ENUM type: 1. initial offer; 2. tourguide-counter offer; 3. customer counter-offer; 4. tourguide-settled offer; 5. customer-settled offer.
  intended_arrive_date		date,
  number_of_days		INT(1),
  offer_daily_rate		FLOAT,
  offer_time			datetime,
  FOREIGN KEY (customer_user_id) REFERENCES Users(id),
  FOREIGN KEY (tourguide_user_id) REFERENCES Users(id)
) ENGINE=InnoDB;

CREATE TABLE Quotes (
  id				INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  flight_rate_estimate		FLOAT,
  transport_rate_estimate	FLOAT,
  lodge_rate_estimate		FLOAT,
  board_rate_estimate		FLOAT
) ENGINE=InnoDB;

