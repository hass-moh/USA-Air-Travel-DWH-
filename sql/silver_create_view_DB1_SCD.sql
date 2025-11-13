USE [AirtravelSilverTest]
GO

/****** Object:  View [dbo].[v_DB1_SCD]    Script Date: 31-10-25 14:04:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER     view [dbo].[v_DB1_SCD]
AS (

SELECT 
BD1.*
, Ap1.AIRPORT_SEQ_ID AS SK_ORIGIN_AIRPORT_SEQ_ID
, Ap2.AIRPORT_SEQ_ID AS SK_DEST_AIRPORT_SEQ_ID 
, C.SK_UNIQUE_ID AS SK_UNIQUE_CARRIER_ENTITY
FROM AirtravelBronze2.dbo.v_DB1 BD1
LEFT JOIN AirtravelSilverTest.dbo.Airports Ap1 ON BD1.ORIGIN_AIRPORT_SEQ_ID = Ap1.AIRPORT_SEQ_ID
LEFT JOIN AirtravelSilverTest.dbo.Airports Ap2 ON BD1.DEST_AIRPORT_SEQ_ID = Ap2.AIRPORT_SEQ_ID
LEFT JOIN AirtravelSilverTest.dbo.Carriers C ON BD1.UNIQUE_CARRIER = C.BK_UNIQUE_CARRIER COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE 
    Ap1.AIRPORT_SEQ_ID = (
        SELECT MAX(AIRPORT_SEQ_ID) FROM AirtravelSilverTest.dbo.Airports
        WHERE AIRPORT_SEQ_ID = BD1.ORIGIN_AIRPORT_SEQ_ID
    )
    AND
    Ap2.AIRPORT_SEQ_ID = (
        SELECT MAX(AIRPORT_SEQ_ID) FROM AirtravelSilverTest.dbo.Airports
        WHERE AIRPORT_SEQ_ID = BD1.DEST_AIRPORT_SEQ_ID
    )
    AND 
    C.SK_UNIQUE_ID = (
        SELECT MAX(SK_UNIQUE_ID) FROM AirtravelSilverTest.dbo.Carriers
        WHERE BK_UNIQUE_CARRIER COLLATE SQL_Latin1_General_CP1_CI_AS = BD1.UNIQUE_CARRIER
    )

)
GO

