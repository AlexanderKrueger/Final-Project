CREATE TABLE IF NOT EXISTS ServerClusters
(ClusterID int (10) not null auto_increment,
RegionID int (10) not null,
accountID int( 10) not null),
CONSTRAINT pk_CluserID primary key(ClusterID),
CONSTRAINT fk_accountID FOREIGN KEY(accountID),
CONSTRAINT fk_RegionID FOREIGN KEY(RegionID)
)
CREATE TABLE IF NOT EXISTS Region
(RegionID int (10) not null auto_increment,
RegionName varchar (20) not null,
ClusterID int (10) not null,
CONSTRAINT pk_RegionID primary KEY (RegionID),
CONSTRAINT fk_ClusterID FOREIGN KEY (ClusterID)
)
CREATE TABLE IF NOT EXISTS Genere
(GenereID int (10) not null auto_increment,
GenereName varchar (20) not null,
CONSTRAINT pk_GenereID primary KEY (GenereID)
)
CREATE TABLE IF NOT EXISTS Advertisments
(AdvertismentID int (10) not null auto_increment,
AdvertismentLength int (5) not null,
AdvertismentPay int (10) not null,
TargetGeneres varchar (20) not null,
CONSTRAINT pk_AdvertismentID primary key (AdvertismentID)
)
create table if not exists GenereGroups
(AdvertismentID int (10) not null,
GenereID int (10) not null,
AccountID int (10) not null,
CONSTRAINT fk_AdvertismentID Foreign key (AdvertismentID)
CONSTRAINT fk_GenereID FOREIGN KEY (GenereID)
CONSTRAINT fk_AccountID foreign key (AccountID)
)
create table if not exists VideoContent
(VideoContentID int (10) not null auto_increment,
VideoContent varchar (20) not null,
CONSTRAINT pk_VideoContentID Primary key (VideoContentID)
)
create table if not exists Subscription
(SubscriptionID int (10) not null auto_increment,
SubscriptionName varchar(20) not null,
SubscriptionPrice int (20) not null,
AccountID int (10) not null,
CONSTRAINT pk_SubscriptionID primary key (SubscriptionID)
CONSTRAINT fk_AccountID foreign key (AccountID)
)

/*
(
AccountID INT (10) NOT NULL AUTO_INCREMENT,
UserName VARCHAR (20) NOT NULL,
-- should "pass_word" be "password"
Pass_word VARCHAR (15) NOT NULL,
SubscriptionId Int (10) NOT NULL, 
Address VARCHAR (30) NOT NULL,
City CHAR (20) NOT NULL,
State CHAR (2) NOT NULL,
Zip VARCHAR (15) NOT NULL,
Country CHAR (50) NOT NULL,
CONSTRAINT pk_AccountId PRIMARY KEY(AccountId)
)*/