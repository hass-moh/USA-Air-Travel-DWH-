
---- FARES_DETAILS View Clean ---

USE AirtravelSilverTest
GO



CREATE OR ALTER VIEW v_FARES_DETAILS AS 
WITH FareCounts AS (
    SELECT
        BK_QYEAR_ORI_DEST,
        MARKET_FARE,
        COUNT(*) AS FareFrequency
    FROM Fact_DB1_Final
    GROUP BY
        BK_QYEAR_ORI_DEST,
        MARKET_FARE
),
ModeFare AS (
    SELECT
        BK_QYEAR_ORI_DEST,
        MARKET_FARE AS MODE_FARE
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY BK_QYEAR_ORI_DEST ORDER BY FareFrequency DESC) AS rn
        FROM FareCounts
    ) t
    WHERE rn = 1
)
SELECT
    m.BK_QYEAR_ORI_DEST,
    mf.MODE_FARE,
    CAST(AVG(m.MARKET_DISTANCE) AS INT) AS AVG_MARKET_DISTANCE
FROM (
    SELECT 
        BK_QYEAR_ORI_DEST,
        MARKET_DISTANCE
    FROM Fact_DB1_Final
) AS m
INNER JOIN ModeFare mf
    ON m.BK_QYEAR_ORI_DEST = mf.BK_QYEAR_ORI_DEST
GROUP BY m.BK_QYEAR_ORI_DEST, mf.MODE_FARE 