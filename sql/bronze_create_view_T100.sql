
---- T100 View Clean ---

USE AirtravelBronze
GO


CREATE OR ALTER VIEW v_T100 AS (
SELECT 
    CONCAT (T1.QUARTER, '-',T1.YEAR,'-',T1.ORIGIN_AIRPORT_SEQ_ID,'-', T1.DEST_AIRPORT_SEQ_ID,'-', T1.UNIQUE_CARRIER_ENTITY ) AS Route_ID
    , CONCAT (T1.QUARTER, '-',T1.YEAR,'-',T1.ORIGIN_AIRPORT_SEQ_ID,'-', T1.DEST_AIRPORT_SEQ_ID ) AS QYEAR_ORI_DEST
	, MC.AIRPORT_SEQ_ID AS ORIGIN_AIRPORT_SEQ_ID
	, MC2.AIRPORT_SEQ_ID AS DEST_AIRPORT_SEQ_ID
    , CD.UNIQUE_CARRIER_ENTITY 
    , AT.Code AS AIRCRAFT_CODE
    , T1.DISTANCE_GROUP                               -- we consider this variable as a static variable, and so we will use the values from the origin table T100 
    , T1.CLASS                                      -- we consider this variable as a static variable, and so we will use the values from the origin table T100 
    , T1.AIRCRAFT_GROUP                             -- we consider this variable as a static variable, and so we will use the values from the origin table T100
    , CONCAT (T1.MONTH, T1.YEAR) AS MONTH_YEAR
    , T1.DEPARTURES_SCHEDULED 
    , T1.DEPARTURES_PERFORMED 
    , T1.DISTANCE
    , T1.PAYLOAD
    , T1.SEATS
    , T1.PASSENGERS
    , T1.FREIGHT
    , T1.MAIL
    , T1.RAMP_TO_RAMP
    , T1.AIR_TIME
    , T1.AIRCRAFT_CONFIG
    , CASE 
        WHEN T1.DATA_SOURCE = 'DF' THEN 'Domestic Data, Foreign Carriers'
        WHEN T1.DATA_SOURCE = 'DU' THEN 'Domestic Data, US Carriers Only'
        WHEN T1.DATA_SOURCE = 'IF' THEN 'International Data, Foreign Carriers'
        WHEN T1.DATA_SOURCE = 'IU' THEN 'International Data, US Carriers Only'
        ELSE T1.DATA_SOURCE  -- keep other unexpected values as-is
        END AS DATA_SOURCE
FROM T_T100_SEGMENT_ALL_CARRIER AS T1
LEFT JOIN T_MASTER_CORD AS MC ON T1.ORIGIN_AIRPORT_SEQ_ID  = MC.AIRPORT_SEQ_ID 
LEFT JOIN T_MASTER_CORD AS MC2 ON T1.DEST_AIRPORT_SEQ_ID = MC2.AIRPORT_SEQ_ID
LEFT JOIN L_AIRCRAFT_TYPE_TABLE AS AT ON T1.AIRCRAFT_TYPE = AT.Code
LEFT JOIN L_AIRCRAFT_GROUP AS AG ON T1.AIRCRAFT_GROUP = AG.Code
LEFT JOIN v_Carriers_Latest AS CD 
    ON RIGHT('0' + CAST(T1.UNIQUE_CARRIER_ENTITY AS NVARCHAR(50)), 5) = CD.UNIQUE_CARRIER_ENTITY --- this modication is to add a 0 infront of the 4 digit values so it matches DIM table values

)