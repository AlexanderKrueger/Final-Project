DELIMITER //
CREATE PROCEDURE getTop5GeneresAsString()
BEGIN
	DECLARE returnedString CHAR DEFAULT "";
    DECLARE genereName CHAR; -- TODO: change data type
    DECLARE totalViews INT;
    DECLARE loopCount INT;
    
    DECLARE queryResult CURSOR FOR
		SELECT
			genereName, (tv.views + movie.views) AS TotalViews
		FROM
			Genere g JOIN TvSeries tv ON g.genereID = tv.genereID
					 JOIN Movies	m ON g.genereID = m.genereID
		GROUP BY
			genereName
		LIMIT 5;
	
    OPEN queryResult;
    SET loopCount = 0;
    REPEAT
		-- fetch stuff from 'queryResult' and send it into variables genereName, totalViews
		FETCH queryResult INTO genereName, totalViews;
        SET returnedString = CONCAT(returndedString, genereName, " Views: ", totalViews, ", ");
        SET loopCount = loopCount + 1;
	-- end value of loopCount = number of items - 1; last item is added outside the loop
	UNTIL (loopCount = 3)
	END REPEAT;
    -- concat last item
	SET returnedString = CONCAT(returndedString, genereName, " Views: ", totalViews);
    CLOSE queryResult;
    
    SELECT
		returnedString AS top5Generes;
END//