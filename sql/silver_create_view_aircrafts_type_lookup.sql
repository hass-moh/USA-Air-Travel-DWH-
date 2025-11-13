USE [AirtravelSilver]
GO

/****** Object:  View [dbo].[v_Aircrafts_Type_Lookup_import]    Script Date: 05-11-25 10:20:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   VIEW [dbo].[v_Aircrafts_Type_Lookup_import]
AS
SELECT 
AIRCRAFT_TYPE
, [DESCRIPTION] COLLATE SQL_Latin1_General_CP1_CI_AS AS [DESCRIPTION]
FROM AirtravelBronze2.dbo.v_Aircrafts_Type_Lookup
EXCEPT 
SELECT 
AIRCRAFT_TYPE
, [DESCRIPTION] 
FROM AirtravelSilver.dbo.Aircrafts_Type_Lookup
GO


