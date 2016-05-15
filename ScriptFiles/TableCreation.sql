DROP DATABASE IF EXISTS VideoStreemers;
CREATE DATABASE VideoStreemers;
USE VideoStreemers;
CREATE TABLE IF NOT EXISTS Account
(
AccountID INT (10) NOT NULL AUTO_INCREMENT,
UserName VARCHAR (20) NOT NULL,
Password VARCHAR (15) NOT NULL,
SubscriptionId INT (10) NOT NULL, 
AddressID INT (10) NOT NULL,
CONSTRAINT pk_AccountId PRIMARY KEY(AccountId)
);
CREATE TABLE IF NOT EXISTS Servers
(
ServerId INT (10) NOT NULL AUTO_INCREMENT,
ClusterID INT (10) NOT NULL,
ServerAge INT (15) NOT NULL,
RunningCostPerHour DECIMAL (4, 2) NOT NULL,
WritingPerformance INT (15) NOT NULL,
ReadingPerformance INT (15) NOT NULL,
CONSTRAINT pk_ServerId PRIMARY KEY (ServerId)
);
CREATE TABLE IF NOT EXISTS ServerClusters
(
ClusterID INT (10) NOT NULL AUTO_INCREMENT,
RegionID INT (10) NOT NULL,
CONSTRAINT pk_ClusterID PRIMARY KEY (ClusterID)
);
CREATE TABLE IF NOT EXISTS Region
(
RegionID INT (10) NOT NULL AUTO_INCREMENT,
RegionName VARCHAR(30) NOT NULL,
CONSTRAINT pk_RegionID PRIMARY KEY(RegionID)
);
CREATE TABLE IF NOT EXISTS Genere
(
GenereID INT (10) NOT NULL AUTO_INCREMENT,
GenereName VARCHAR (20) NOT NULL,
CONSTRAINT pk_GenereID PRIMARY KEY (GenereID)
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
AdvertismentID INT (10) NOT NULL AUTO_INCREMENT,
advertiser VARCHAR (40) not null,
AdvertismentLength TIME NOT NULL,
AdvertismentPay DECIMAL (10, 2) NOT NULL,
-- TargetGeneres is a foreign key for generegroups
TargetGeneres INT (10) NOT NULL,
CONSTRAINT pk_AdvertismentID PRIMARY KEY (AdvertismentID)
);
CREATE TABLE IF NOT EXISTS GenereGroups
(
GenereGroupID INT (10) NOT NULL AUTO_INCREMENT,
GenereID INT (10) NOT NULL,
GroupForTvSeriesID INT (10) DEFAULT NULL, -- Not a foreign key
GroupForMovieID INT (10) DEFAULT NULL, -- Not a foreign key
GroupForAdvertismentID INT (10) DEFAULT NULL, -- Not a foreign key
CHECK (TvSeriesID IS NULL OR MovieID IS NULL OR AdvertismentID IS NULL),
CONSTRAINT pk_GenereGroupID PRIMARY KEY (GenereGroupID)
);
CREATE TABLE IF NOT EXISTS VideoContent
(
VideoContentID INT (10) NOT NULL AUTO_INCREMENT,
VideoContent VARCHAR (20) NOT NULL,
CONSTRAINT pk_VideoContentID PRIMARY KEY (VideoContentID)
);
CREATE TABLE IF NOT EXISTS Subscription
(
SubscriptionID INT (10) NOT NULL AUTO_INCREMENT,
SubscriptionName VARCHAR(22) NOT NULL,
SubscriptionPrice DECIMAL (10, 2) NOT NULL,
CONSTRAINT pk_SubscriptionID PRIMARY KEY (SubscriptionID)
);
CREATE TABLE IF NOT EXISTS Billing 
(
BillingId INT (15) NOT NULL AUTO_INCREMENT,
CreditCardInfo VARCHAR (16) NOT NULL,
AccountID INT (10) NOT NULL,
AddressID INT (10) NOT NULL,
CONSTRAINT pk_BillingId PRIMARY KEY (BillingId)
);
CREATE TABLE IF NOT EXISTS Episodes
(
EpisodeID INT (15) NOT NULL AUTO_INCREMENT,
VideoContentID INT (20) NOT NULL,
EpisodeName VARCHAR (20) NOT NULL,
EpisodeDescription VARCHAR (50) NOT NULL,
Views INT (10) NOT NULL,
CONSTRAINT pk_EpisodeID PRIMARY KEY (EpisodeID)
);
CREATE TABLE IF NOT EXISTS Movies
(
MovieID INT (15) NOT NULL AUTO_INCREMENT,
-- GenereGroupID INT (10) NOT NULL,
VideoContentID INT (10) NOT NULL,
MovieName VARCHAR (30) NOT NULL,
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
);
CREATE TABLE IF NOT EXISTS TvSeries
(
TvSeriesID INT (15) NOT NULL AUTO_INCREMENT,
-- GenereGroupID INT (10) NOT NULL,
SeriesName VARCHAR (30) NOT NULL,
CONSTRAINT pk_TvSeriesID PRIMARY KEY (TvSeriesID)
);

ALTER TABLE Servers
ADD CONSTRAINT fk_ClusterIDInServers FOREIGN KEY (ClusterID) REFERENCES ServerClusters (ClusterID);

ALTER TABLE ServerClusters
ADD CONSTRAINT fk_RegionIDInServerClusters FOREIGN KEY (RegionID) REFERENCES Region (RegionID);

ALTER TABLE GenereGroups
ADD CONSTRAINT fk_GenereID FOREIGN KEY (GenereID) REFERENCES Genere (GenereID);
-- ADD CONSTRAINT fk_TvSeriesIDInGenereGroups FOREIGN KEY (TvSeriesID) REFERENCES TvSeries (TvSeriesID),
-- ADD CONSTRAINT fk_MovieIDInGenereGroups FOREIGN KEY (MovieID) REFERENCES Movies (MovieID);

-- ALTER TABLE TvSeries
-- ADD CONSTRAINT fk_GenereGroupsIDInTvSeries FOREIGN KEY (GenereGroupID) REFERENCES GenereGroups (GenereGroupID);

ALTER TABLE Advertisments
ADD CONSTRAINT fk_GenereGroupsInAdvertisments FOREIGN KEY (TargetGeneres) REFERENCES GenereGroups (GenereGroupID);

ALTER TABLE Billing
ADD CONSTRAINT fk_AccountIDInBilling FOREIGN KEY (AccountID) REFERENCES Account (AccountID),
ADD CONSTRAINT fk_AddressIDInBilling FOREIGN KEY (AddressID) REFERENCES Addresses (AddressID);

ALTER TABLE Episodes
ADD CONSTRAINT fk_VideoContentIDInEpisodes FOREIGN KEY (VideoContentID) REFERENCES VideoContent (VideoContentID);

ALTER TABLE Movies
ADD CONSTRAINT fk_VideoContentIDInMovies FOREIGN KEY (VideoContentID) REFERENCES VideoContent (VideoContentID);
-- ADD CONSTRAINT fk_GenereGroupIDInMovies FOREIGN KEY (GenereGroupID) REFERENCES GenereGroups (GenereGroupID);

ALTER TABLE Season
ADD CONSTRAINT fk_EpisodeID FOREIGN KEY (EpisodeID) REFERENCES Episodes (EpisodeID),
ADD CONSTRAINT fk_TvSeriesID FOREIGN KEY (TvSeriesID) REFERENCES TvSeries (TvSeriesID);

ALTER TABLE Account
ADD CONSTRAINT fk_AddressIDInAccount FOREIGN KEY (AddressID) REFERENCES Addresses (AddressID),
ADD CONSTRAINT fk_SubscriptionIDInAccount FOREIGN KEY (SubscriptionID) REFERENCES Subscription (SubscriptionID);

