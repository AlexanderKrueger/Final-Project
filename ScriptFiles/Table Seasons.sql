create table IF NOT EXISTS Season
(
SeasonID INT (15) NOT NULL AUTO_INCREMENT,
EpisodeID  INT (15) NOT NULL,
TvSeriesID INT (15) NOT NULL,
SeasonNumber INT (2) NOT NULL,
CONSTRAINT pk_SeasonID PRIMARY KEY (SeasonID),
CONSTRAINT fk_EpisodeID FOREIGN KEY (EpisodeID) REFERENCES Episodes (EpisodeID),
CONSTRAINT fk_TvSeriesID FOREIGN KEY (TvSeriesID) REFERENCES TvSeries (TvSeriesID)
)