CREATE OR REPLACE VIEW ServerStatsView AS
(
SELECT
        RegionName,
	ROUND(AVG(RunningCostPerHour), 2) AS AvgClusterMaintenceCost,
	ROUND(AVG(WritingPerformance), 3) AS AvgReadingPerformance,
	ROUND(AVG(ReadingPerformance), 3) AS AvgWritingPerformance
FROM
	Servers JOIN ServerClusters ON Servers.ClusterID = ServerClusters.ClusterID
		    JOIN Region	        ON ServerClusters.RegionID = Region.RegionID
GROUP BY
	ClusterID
ORDER BY
	RegionName
);

CREATE OR REPLACE VIEW ContentPopularityView AS
(
SELECT
	MostPopularShowQuery.Result AS MostPopularShow,
	MostPopularMovieQuery.Result AS MostPopularMovie
	-- procedure 'getTop5GeneresAsString' needs to be created before use
	getTop5GeneresAsString() AS TopFiveGeneres
FROM	
	-- Subquerys
	(
	SELECT
		CONCAT(BaseQuery.SeriesName, ", Views: ", BaseQuery.Views) AS Result
	FROM
		(
		SELECT
			SUM(Views) AS SumViews
		FROM
			TvSeries JOIN Seasion 	ON TvSeries.TvSeriesId 	= Seasion.TvSeriesId
				 JOIN Episoids 	ON Seasion.EpisoidID 	= Episiods.EpisoidID
		) AS BaseQuery
		
	GROUP BY
		TvSeries
	HAVING
		BaseQuery.Views = Max(BaseQuery.SumViews)
	LIMIT 1;	
	) AS MostPopularShowQuery
);

CREATE OR REPLACE VIEW MoneyStatsView AS
(
SELECT
	CostsQuery.Result AS Costs,
	GainsQuery.Result AS Gains,
	(CostsQuery.Result - GainsQuery.Result) AS Profit

FROM
	(
	SELECT
		-- running cost per year
		SUM(RunningCostPerHour * 8760) AS Result
	FROM
		Servers
	) AS CostsQuery,
	(
	SELECT
		-- assumes yearly price  -- assumes 4 advertisments per hour done all year
		SUM(SubscriptionPrice) + Sum(AdvertismentPay * 4 * 8760) AS Result
	FROM
		Account JOIN Subscription ON Account.SubscriptionID = Subscription.SubscriptionID,
		Advertisments
	) AS GainsQuery
);