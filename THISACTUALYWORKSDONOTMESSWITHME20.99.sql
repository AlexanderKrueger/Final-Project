Drop database if exists VideoStreemers;
Create Database VideoStreemers;
Use VideoStreemers;
CREATE TABLE IF NOT EXISTS Account
(
AccountID INT (10) NOT NULL AUTO_INCREMENT,
UserName VARCHAR (20) NOT NULL,
Password VARCHAR (15) NOT NULL,
SubscriptionId Int (10) NOT NULL, 
AddressID INT (10) NOT NULL,
CONSTRAINT pk_AccountId PRIMARY KEY(AccountId)
);

CREATE TABLE IF NOT EXISTS ServerClusters
(
ClusterID int (10) not null auto_increment,
RegionID int (10) not null,
ServerID int (10) not null,
AccountID int (10) not null,
CONSTRAINT pk_ClusterID primary key (ClusterID)
);
create table if not exists Region
(
RegionID int (10) not null,
AccountID int( 10) not null,
CONSTRAINT pk_RegionID primary key(RegionID)
-- CONSTRAINT fk_accountID FOREIGN KEY(accountID)
-- References Account (AccountId)
);
CREATE TABLE IF NOT EXISTS Genere
(
GenereID int (10) not null auto_increment,
GenereName varchar (20) not null,
CONSTRAINT pk_GenereID primary KEY (GenereID)
);
CREATE TABLE IF NOT EXISTS Addresses
(
AddressID INT(10) NOT NULL AUTO_INCREMENT,
Address VARCHAR (30) NOT NULL,
City CHAR (20) NOT NULL,
State CHAR (2) NOT NULL,
Zip VARCHAR (15) NOT NULL,
Country CHAR (50) NOT NULL,
CONSTRAINT pk_Addresses PRIMARY KEY(AddressID)
);
CREATE TABLE IF NOT EXISTS Advertisments
(
AdvertismentID int (10) not null auto_increment,
advertiser varchar (40) not null,
AdvertismentLength int (5) not null,
AdvertismentPay int (10) not null,
TargetGeneres varchar (20) not null,
CONSTRAINT pk_AdvertismentID primary key (AdvertismentID)
);
create table if not exists GenereGroups
(
AdvertismentID int (10) not null,
GenereID int (10) not null,
AccountID int (10) not null
-- CONSTRAINT fk_AdvertismentID Foreign key (AdvertismentID)
-- References Advertisment (AdvertismentID),
-- CONSTRAINT fk_GenereID FOREIGN KEY (GenereID)
-- References Genere (GenereID),
-- CONSTRAINT fk_AccountID foreign key (AccountID)
-- References Account (AccountID)
);
create table if not exists VideoContent
(
VideoContentID int (10) not null auto_increment,
VideoContent varchar (20) not null,
CONSTRAINT pk_VideoContentID Primary key (VideoContentID)
);
create table if not exists Subscription
(
SubscriptionID int (10) not null auto_increment,
SubscriptionName varchar(20) not null,
SubscriptionPrice int (20) not null,
AccountID int (10) not null,
CONSTRAINT pk_SubscriptionID primary key (SubscriptionID)
-- CONSTRAINT fk_AccountID foreign key (AccountID)
-- References Account (AccountID)
);
CREATE TABLE IF NOT EXISTS Billing 
(
BillingId INT (15) NOT NULL AUTO_INCREMENT,
CreditCardInfo INT (25) NOT NULL,
AccountID INT (10) NOT NULL,
AddressID INT (10) NOT NULL,
CONSTRAINT pk_BillingId PRIMARY KEY (BillingId)
-- CONSTRAINT fk_AccountID FOREIGN KEY (AccountID) REFERENCES Account (AccountID)
);
CREATE TABLE IF NOT EXISTS Episodes
(
EpisodeID INT (15) NOT NULL AUTO_INCREMENT,
VideoContentID INT (20) NOT NULL,
GenreID INT (10) NOT NULL,
EpisodeName VARCHAR (20) NOT NULL,
EpisodeDescription VARCHAR (50) NOT NULL,
Views INT (10) NOT NULL,
CONSTRAINT pk_EpisodeID PRIMARY KEY (EpisodeID)
);
CREATE TABLE IF NOT EXISTS Movies
(
MovieID INT (15) NOT NULL AUTO_INCREMENT,
VideoContentID INT (10) NOT NULL,
MovieName varchar (30) not null,
Views INT (10) NOT NULL,
CONSTRAINT pk_MovieID PRIMARY KEY (MovieID)
);
create table IF NOT EXISTS Season
(
SeasonID INT (15) NOT NULL AUTO_INCREMENT,
EpisodeID  INT (15) NOT NULL,
TvSeriesID INT (15) NOT NULL,
SeasonNumber INT (2) NOT NULL,
CONSTRAINT pk_SeasonID PRIMARY KEY (SeasonID)
-- CONSTRAINT fk_EpisodeID FOREIGN KEY (EpisodeID) REFERENCES Episodes (EpisodeID),
-- CONSTRAINT fk_TvSeriesID FOREIGN KEY (TvSeriesID) REFERENCES TvSeries (TvSeriesID)
);
CREATE TABLE IF NOT EXISTS Servers
(
ServerId INT (15) NOT NULL AUTO_INCREMENT,
ClusterId INT (15) NOT NULL,
ServerAge INT (15) NOT NULL,
RunningCostPerHour DECIMAL (4) NOT NULL,
WritingPerformance INT (15) NOT NULL,
ReadingPerformance INT (15) NOT NULL,
CONSTRAINT pk_ServerId PRIMARY KEY (ServerId)
);
CREATE TABLE IF NOT EXISTS TvSeries
(
TvSeriesID INT (15) NOT NULL AUTO_INCREMENT,
SeriesName VARCHAR (25) NOT NULL,
VideoContentID INT (20) NOT NULL,
CONSTRAINT pk_TvSeriesID PRIMARY KEY (TvSeriesID)
);

ALTER TABLE ServerClusters
ADD CONSTRAINT fk_AccountID FOREIGN KEY(AccountID) REFERENCES Account (AccountId),
ADD CONSTRAINT fk_RegionID FOREIGN KEY (RegionID) REFERENCES Region (RegionID),
ADD CONSTRAINT fk_ServerID FOREIGN KEY (ServerID) REFERENCES Servers (ServerID);

ALTER TABLE GenereGroups
ADD CONSTRAINT fk_AdvertismentID FOREIGN KEY (AdvertismentID) REFERENCES Advertisments (AdvertismentID),
ADD CONSTRAINT fk_GenereID FOREIGN KEY (GenereID) REFERENCES Genere (GenereID),
ADD CONSTRAINT fk_AccountIDInGenereGroups FOREIGN KEY (AccountID) REFERENCES Account (AccountID);

ALTER TABLE Subscription
ADD CONSTRAINT fk_AccountIDInSubscription FOREIGN KEY (AccountID) REFERENCES Account (AccountID);

ALTER TABLE Billing
ADD CONSTRAINT fk_AccountIDInBilling FOREIGN KEY (AccountID) REFERENCES Account (AccountID),
ADD CONSTRAINT fk_AddressIDInBilling FOREIGN KEY (AddressID) REFERENCES Addresses (AddressID);

ALTER TABLE Episodes
ADD CONSTRAINT fk_VideoContentIDInEpisodes FOREIGN KEY (VideoContentID) REFERENCES VideoContent (VideoContentID);

ALTER TABLE Movies
ADD CONSTRAINT fk_VideoContentIDInMovies FOREIGN KEY (VideoContentID) REFERENCES VideoContent (VideoContentID);

ALTER TABLE Season
ADD CONSTRAINT fk_EpisodeID FOREIGN KEY (EpisodeID) REFERENCES Episodes (EpisodeID),
ADD CONSTRAINT fk_TvSeriesID FOREIGN KEY (TvSeriesID) REFERENCES TvSeries (TvSeriesID);

ALTER TABLE Account
ADD CONSTRAINT fk_AddressIDInAccount FOREIGN KEY (AddressID) REFERENCES Addresses (AddressID);
