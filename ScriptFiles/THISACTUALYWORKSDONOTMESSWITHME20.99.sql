Create Database VideoStreemers;
Use VideoStreemers;
CREATE TABLE IF NOT EXISTS Account
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
);

CREATE TABLE IF NOT EXISTS ServerClusters
(
ClusterID int (10) not null auto_increment,
AccountID int (10) not null,
CONSTRAINT pk_ClusterID primary key (ClusterID)
);
create table if not exists Region
(
RegionID int (10) not null,
accountID int( 10) not null,
CONSTRAINT pk_RegionID primary key(RegionID)
-- CONSTRAINT fk_accountID FOREIGN KEY(accountID)
-- References Account (AccountId),
-- CONSTRAINT fk_RegionID FOREIGN KEY(RegionID)
-- References Region (RegionID)
);


CREATE TABLE IF NOT EXISTS Genere
(GenereID int (10) not null auto_increment,
GenereName varchar (20) not null,
CONSTRAINT pk_GenereID primary KEY (GenereID)
);
CREATE TABLE IF NOT EXISTS Advertisments
(AdvertismentID int (10) not null auto_increment,
AdvertismentLength int (5) not null,
AdvertismentPay int (10) not null,
TargetGeneres varchar (20) not null,
CONSTRAINT pk_AdvertismentID primary key (AdvertismentID)
);
create table if not exists GenereGroups
(AdvertismentID int (10) not null,
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
(VideoContentID int (10) not null auto_increment,
VideoContent varchar (20) not null,
CONSTRAINT pk_VideoContentID Primary key (VideoContentID)
);
create table if not exists Subscription
(SubscriptionID int (10) not null auto_increment,
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
VideoContentID INT (20) NOT NULL,
Views INT (10) NOT NULL,
CONSTRAINT pk_MovieID PRIMARY KEY (MovieID)
-- CONSTRAINT fk_VideoContentID FOREIGN KEY (VideoContentID) REFERENCES Episodes (VideoContentID)
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
-- CONSTRAINT fk_ClusterId FOREIGN KEY (ClusterId) REFERENCES ServerClusters (ClusterID)
);
CREATE TABLE IF NOT EXISTS Tv_Series
(
TvSeriesID INT (15) NOT NULL AUTO_INCREMENT,
SeriesName VARCHAR (25) NOT NULL,
VideoContentID INT (20) NOT NULL,
CONSTRAINT pk_TvSeriesID PRIMARY KEY (TvSeriesID)
-- CONSTRAINT fk_VideoContentID FOREIGN KEY (VideoContentID) REFERNECES Episodes (VideoContentID)
);


