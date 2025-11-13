USE [AirtravelSilver]
GO

/****** Object:  View [dbo].[v_Aircrafts_SCD]    Script Date: 05-11-25 10:10:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER           VIEW [dbo].[v_Aircrafts_SCD]
AS (
    SELECT vA.*, ATY.SK_ID AS FK_AIRCRAFT_TYPE, C.SK_UNIQUE_ID AS FK_CARRIER_ID  FROM [AirtravelBronze2].[dbo].v_Aircrafts vA
    LEFT JOIN [AirtravelSilver].[dbo].Aircrafts_type ATY ON vA.AIRCRAFT_TYPE = ATY.AIRCRAFT_TYPE
    LEFT JOIN [AirtravelSilver].[dbo].Carriers C ON vA.UNIQUE_CARRIER COLLATE SQL_Latin1_General_CP1_CI_AS = C.BK_UNIQUE_CARRIER
    WHERE 
    ATY.SK_ID IN (
        SELECT TOP 1 SK_ID 
        FROM [AirtravelSilver].[dbo].Aircrafts_type
        WHERE AIRCRAFT_TYPE = vA.AIRCRAFT_TYPE
        ORDER BY SK_ID DESC
    )
    AND
    C.SK_UNIQUE_ID IN (
        SELECT TOP 1 SK_UNIQUE_ID 
        FROM [AirtravelSilver].[dbo].Carriers
        WHERE BK_UNIQUE_CARRIER = vA.UNIQUE_CARRIER COLLATE SQL_Latin1_General_CP1_CI_AS
        ORDER BY SK_UNIQUE_ID DESC
    )

)
GO


