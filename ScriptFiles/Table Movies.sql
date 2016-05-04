CREATE TABLE IF NOT EXISTS Movies
(
MovieID INT (15) NOT NULL AUTO_INCREMENT,
VideoContentID INT (20) NOT NULL,
Views INT (10) NOT NULL,
CONSTRAINT pk_MovieID PRIMARY KEY (MovieID),
CONSTRAINT fk_VideoContentID FOREIGN KEY (VideoContentID) REFERENCES Episodes (VideoContentID)
)