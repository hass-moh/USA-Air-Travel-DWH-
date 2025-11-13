USE [AirtravelSilverTest]
GO

/****** Object:  View [dbo].[v_T100SCD]    Script Date: 31-10-25 14:05:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER     view [dbo].[v_T100SCD]
AS (
SELECT 
vT100.*
, Ap1.AIRPORT_SEQ_ID AS SK_ORIGIN_AIRPORT_SEQ_ID
, Ap2.AIRPORT_SEQ_ID AS SK_DEST_AIRPORT_SEQ_ID 
, Ca.SK_ID AS SK_UNIQUE_CARRIER_ENTITY
, ATL.SK_ID AS SK_AIRCRAFT_CODE
FROM AirtravelBronze2.dbo.v_T100 vT100
LEFT JOIN AirtravelSilverTest.dbo.Airports Ap1 ON vT100.ORIGIN_AIRPORT_SEQ_ID = Ap1.AIRPORT_SEQ_ID
LEFT JOIN AirtravelSilverTest.dbo.Airports Ap2 ON vT100.DEST_AIRPORT_SEQ_ID = Ap2.AIRPORT_SEQ_ID
LEFT JOIN AirtravelSilverTest.dbo.Carriers_Details Ca ON vT100.UNIQUE_CARRIER_ENTITY_PADDED = Ca.UNIQUE_CARRIER_ENTITY COLLATE SQL_Latin1_General_CP1_CI_AS
LEFT JOIN AirtravelSilverTest.dbo.Aircrafts_Type_Lookup ATL ON vT100.AIRCRAFT_CODE = ATL.AIRCRAFT_TYPE
WHERE 
    Ap1.AIRPORT_SEQ_ID = (
        SELECT MAX(AIRPORT_SEQ_ID) FROM AirtravelSilverTest.dbo.Airports
        WHERE AIRPORT_SEQ_ID = vT100.ORIGIN_AIRPORT_SEQ_ID
    )
    AND
    Ap2.AIRPORT_SEQ_ID = (
        SELECT MAX(AIRPORT_SEQ_ID) FROM AirtravelSilverTest.dbo.Airports
        WHERE AIRPORT_SEQ_ID = vT100.DEST_AIRPORT_SEQ_ID
    )
    AND 
    Ca.SK_ID = (
        SELECT MAX(SK_ID) FROM AirtravelSilverTest.dbo.Carriers_Details
        WHERE UNIQUE_CARRIER_ENTITY COLLATE SQL_Latin1_General_CP1_CI_AS = vT100.UNIQUE_CARRIER_ENTITY_PADDED
    )
    AND 
    ATL.SK_ID = (
        SELECT MAX(SK_ID) FROM AirtravelSilverTest.dbo.Aircrafts_Type_Lookup
        WHERE AIRCRAFT_TYPE  = vT100.AIRCRAFT_CODE
        )
)
GO

