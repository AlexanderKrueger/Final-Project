-- CountPasswordsPerStrength
    SELECT
        COUNT(WeakPasswordsQuery.Result) AS 'Total Weak Passwords',
        COUNT(SemiStrongPasswordsQuery.Result) AS 'Total Semi-strong Passwords',
        COUNT(StrongPasswordsQuery.Result) AS 'Total Strong Passwords'
    FROM
        (
        SELECT
            password AS Result
        FROM
        Accounts
        WHERE
            password NOT REGEXP "[a-zA-Z[:digit:][!@#$%^&*_+-=:;<>?/~`|\{}[.(.][.).][:right-square-bracket:][:left-square-bracket:]]]+"
        ) AS WeakPasswordsQuery,
        (
        SELECT
            password AS Result
        FROM
        Accounts
        WHERE
            pass_word NOT REGEXP "[a-zA-Z[:digit:]]+" OR password NOT REGEXP "[!@#$%^&*_+-=:;<>?/~`|\{}[.(.][.).][:right-square-bracket:][:left-square-bracket:]]+"
        ) AS SemiStrongPasswordsQuery,
        (
        SELECT
            password AS Result
        FROM
        Accounts
        WHERE
            password REGEXP "[a-zA-Z[:digit:]!@#$%^&*_+-=:;<>?/~`|\{}[.(.][.).][:right-square-bracket:][:left-square-bracket:]]+"
        ) AS StrongPasswordsQuery
        ,Accounts;

-- ListAllEpisoidsBySeasion
    SELECT
        SeriesName,
        SeasionNumber,
        EpisoideNumber,
        EpisoideName
    FROM
        TvSeries tv JOIN Seasion  s ON tv.TvSeriesId = s.TvSeriesId
                    JOIN Episoids e ON s.SeasionID = e.SeasionID
    ORDER BY
        TvSeriesId, SeasionNumber, EpisoideID;


--  GeneresByPopularity
    SELECT
        GenereName
        (COUNT(Episoids.Views) + Count(Movies.Views)) AS GenereViews
    FROM
        Episoids JOIN Generes ON Episoids.GenereID = Generes.GenereID
                 JOIN Movies  ON Generes.GenereID = Movies.Generes.GenereID
    GROUP BY
        Genere;

-- ExistingGenereCombinations
    SELECT
        DistinctGenereCombinations.GenereGroupID,
        DistinctGenereCombinations.GenereName
    FROM
        ((Generes g1 JOIN GenereGroups gg1 ON g1.GenereID = gg1.GenereID)
                    JOIN
        (Generes g2 JOIN GenereGroups gg2 ON g2.GenereID = gg2.GenereID)
        ON
        -- applys emulated outer join to each GenereGroup
        -- ----------------------------------------------------------
                      -- (left outer join)       (right outer join)
        gg1 = gg2 AND (g1.GenereName NOT IN(g2.GenereName)  OR  g2.GenereName NOT IN(g1.GenereName)))
        AS DistinctGenereCombinations                 
    ORDER BY
        DistinctGenereCombinations.GenereGroupID, DistinctGenereCombinations.GenereName;   

-- MovieToTvSeriesRatio
    SELECT
        CONCAT(ROUND( COUNT(MovieId)/(Count(MovieId)+COUNT(TvSeriesId)*100)), " : ", ROUND( (1-COUNT(MovieId)/(Count(MovieId)+COUNT(TvSeriesId))*100), 2)) AS Ratio 
	FROM
        Movies, TvSeries;

-- TotalSubscribersForEachSubscribtion
    SELECT
        SubscriptionType1.Total AS 'Subscribed To Type1',
        SubscriptionType2.Total AS 'Subscribed To Type2',
        SubscriptionType3.Total AS 'Subscribed To Type3'
   FROM
        (
        SELECT
            COUNT(Account.SubscriptionID) AS Total
        FROM
            Account JOIN Subscription ON Account.SubscriptionID = Subscription.SubscriptionID
        WHERE
            SubscriptionName = "SubscriptionType1" -- place holder condition
        ) AS SubscriptionType1,
        (
        SELECT
            COUNT(Account.SubscriptionID) AS Total
        FROM
            Account JOIN Subscription ON Account.SubscriptionID = Subscription.SubscriptionID
        WHERE
            SubscriptionName = "SubscriptionType2" -- place holder condition
        ) AS SubscriptionType2,
        (
        SELECT
            COUNT(Account.SubscriptionID) AS Total
        FROM
            Account JOIN Subscription ON Account.SubscriptionID = Subscription.SubscriptionID
        WHERE
            SubscriptionName = "SubscriptionType3" -- place holder condition
        ) AS SubscriptionType3;

-- UsersPerCountry
    SELECT
        COUNT(AccountID) AS TotalUsers,
        Account.Country
    FROM
        Accounts
    GROUP BY
        Country;

-- TotalServerPerformanceOfEachCountry
    SELECT
        RegionName,
        SUM(WritingPerformance) AS 'Total Writing Performance (GBS)',
        SUM(ReadingPerformance) AS 'Total Reading Performance (GBS)'
    FROM
        Servers JOIN ServerClusters ON Servers.ServerID        = ServerClusters.ServerID
                JOIN Regions        ON ServerClusters.RegionID = Regions.RegionID
    GROUP BY
        RegionName;

-- ProfitOfEachCountry
    SELECT
        RegionName,
        ROUND((SUM(SubscriptionPrice) + Sum(AdvertismentPay * 4 * 8760)/COUNT(Regions.RegionID)), 2) - SUM(RunningCostPerHour * 8760) AS Profit
    FROM
        Account JOIN Subscription ON Account.SubscriptionID = Subscription.SubscriptionID,
	Advertisments,
        Servers JOIN ServerClusters ON Servers.ServerID        = ServerClusters.ServerID
                JOIN Regions        ON ServerClusters.RegionID = Regions.RegionID
   GROUP BY
        Regions;