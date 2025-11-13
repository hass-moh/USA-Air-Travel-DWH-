USE [AirtravelBronze]
GO

CREATE OR ALTER VIEW v_Aircrafts_Type_Lookup
AS
SELECT
[Code]
, [Description]
FROM 
[L_AIRCRAFT_TYPE]
GO