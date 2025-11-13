

USE [AirtravelSilver]
GO

--- Diactivate indexes on desitination Fact_DB1_Final -- 

ALTER TABLE dbo.Fact_DB1 NOCHECK CONSTRAINT ALL;


-- Insert new rows from staging into Fact_DB1 without duplicates
INSERT INTO [dbo].[Fact_DB1] (
    MKT_ID,
    BK_QYEAR_ORI_DEST,
    SK_ORIGIN_AIRPORT_SEQ_ID,
    SK_DEST_AIRPORT_SEQ_ID,
    SK_UNIQUE_CARRIER_ID,
    QUARTER_YEAR,
    MARKET_FARE,
    MARKET_DISTANCE
)
SELECT s.MKT_ID,
       s.BK_QYEAR_ORI_DEST,
       s.SK_ORIGIN_AIRPORT_SEQ_ID,
       s.SK_DEST_AIRPORT_SEQ_ID,
       s.SK_UNIQUE_CARRIER_ID,
       s.QUARTER_YEAR,
       s.MARKET_FARE,
       s.MARKET_DISTANCE
FROM Fact_DB1_Stagging s
LEFT JOIN [Fact_DB1] d
       ON s.MKT_ID = d.MKT_ID
      AND s.BK_QYEAR_ORI_DEST = d.BK_QYEAR_ORI_DEST
      AND s.SK_UNIQUE_CARRIER_ID = d.SK_UNIQUE_CARRIER_ID
WHERE d.SK_UNIQUE_ID IS NULL;


-- Reactivate indexes on desitination Fact_DB1_Final -- 

ALTER TABLE dbo.Fact_DB1 WITH CHECK CHECK CONSTRAINT ALL;

-- Optionally truncate the destination staging table (after INSERT In Final table)

TRUNCATE TABLE Fact_DB1_Stagging; 
