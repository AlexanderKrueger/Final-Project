CREATE TABLE IF NOT EXISTS Servers
(
ServerId INT (15) NOT NULL AUTO_INCREMENT,
ClusterId INT (15) NOT NULL,
ServerAge INT (15) NOT NULL,
RunningCostPerHour DECIMAL (4) NOT NULL,
WritingPerformance INT (15) NOT NULL,
ReadingPerformance INT (15) NOT NULL,
CONSTRAINT pk_ServerId PRIMARY KEY (ServerId),
CONSTRAINT fk_ClusterId FOREIGN KEY (ClusterId) REFERENCES ServerClusters (ClusterID)
)