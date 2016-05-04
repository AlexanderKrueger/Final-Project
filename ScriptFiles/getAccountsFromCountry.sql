DELIMITER //
DROP PROCEDURE IF EXISTS getAccountsFromCountry;
CREATE PROCEDURE getAccountsFromCountry(inputCountry CHAR)/* TODO: data type needs to be changed */
BEGIN
    SELECT
        AccountID,
        UserName,
        -- 'Password' not included for privacy reasons
        Subscription,
        Address,
        City,
        State,
        Zip,
        Country
    FROM
        Account
    WHERE
        Country = @inputCountry
    ORDER BY
        UserName;	
END//
DELIMITER ;