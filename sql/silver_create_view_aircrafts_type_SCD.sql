USE [AirtravelSilver]
GO

/****** Object:  View [dbo].[v_Aircrafts_type_SCD]    Script Date: 05-11-25 10:08:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE OR ALTER           VIEW [dbo].[v_Aircrafts_type_SCD]
AS (
    SELECT vA.*, ATY.SK_ID AS FK_AIRCRAFT_TYPE  FROM [AirtravelBronze2].[dbo].v_Aircrafts_Type vA
    LEFT JOIN [AirtravelSilverTest].[dbo].Aircrafts_Type_Lookup ATY ON vA.AIRCRAFT_TYPE_LOOKUP = ATY.AIRCRAFT_TYPE
    WHERE 
    ATY.SK_ID IN (
        SELECT TOP 1 SK_ID 
        FROM [AirtravelSilverTest].[dbo].Aircrafts_Type_Lookup
        WHERE AIRCRAFT_TYPE = vA.AIRCRAFT_TYPE_LOOKUP
        ORDER BY SK_ID DESC
    )
)
GO


