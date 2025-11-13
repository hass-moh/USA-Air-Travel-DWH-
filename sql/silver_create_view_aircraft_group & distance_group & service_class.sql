
use AirtravelSilver
GO

----  L_AIRCRAFT_GROUP view ----- 

CREATE OR ALTER VIEW v_Aircraft_Group AS
SELECT 
    Code,
    REPLACE([DESCRIPTION], '"', '') AS [DESCRIPTION]
FROM AirtravelBronze2.dbo.L_AIRCRAFT_GROUP;

GO
----  L_DISTANCE_GROUP_500 view ---- 

CREATE OR ALTER VIEW v_Distance_Group AS (
SELECT Code
, REPLACE([DESCRIPTION], '"', '') AS [DESCRIPTION]
FROM AirtravelBronze2.dbo.L_DISTANCE_GROUP_500
)

GO

----  L_SERVICE_CLASS view ---- 


CREATE OR ALTER VIEW v_Service_Class AS (
SELECT CAST(Code AS NVARCHAR(3)) AS Code,
    [DESCRIPTION]
FROM AirtravelBronze2.dbo.L_SERVICE_CLASS
)

