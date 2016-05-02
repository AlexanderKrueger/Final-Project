CREATE OR REPLACE VIEW ServerStatsView
(
SELECT
        RegienName,
	ROUND(AVG(RunningCostPerHour), 2) AS AvgClusterMaintenceCost,
	ROUND(AVG(WritingPerformance), 3) AS AvgReadingPerformance,
	ROUND(AVG(ReadingPerformance), 3) AS AvgWritingPerformance,
FROM
	Servers JOIN ServerClusters ON Servers.ClusterID = ServerClusters.ClusterID
		JOIN Region	    ON ServerClusters.RegienID = Region.RegionID
GROUP BY
	ClusterID
ORDER BY
	RegienName;
)

CREATE OR REPLACE VIEW ContentPopularityView
(
SELECT
	MostPopularShowQuery.Result AS MostPopularShow
	MostPopularMovieQuery.Result AS MostPopularMovie
	TopFiveGeneresQuery.Result AS TopFiveGeneres
FROM
	-- Query that all subquerys are joined to
	
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
	)AS MostPopularShowQuery,
	(
	SELECT
		-- TODO: add column MovieName
		CONCAT(MovieName, ", Views: ", Views) AS Result
	FROM
		Movies
	HAVING
		Views = Max(Views);		
	)AS MostPopularMovieQuery,
	(
	SELECT
		AS Result
	FROM
	-- not sure how to pull this subquery off	
	LIMIT 5;	
	)AS TopFiveGeneresQuery,
)

CREATE OR REPLACE VIEW MoneyStatsView
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
					-- assumes 4 advertisments per hour done all year
		SUM(SubscriptionPrice) + Sum(AdvertismentPay * 4 * 8760) AS Result
	FROM
		Account JOIN Subscription ON Account.SubscriptionID = Subscription.SubscriptionID,
		Advertisments
	) AS GainsQuery
)