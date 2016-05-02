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
)