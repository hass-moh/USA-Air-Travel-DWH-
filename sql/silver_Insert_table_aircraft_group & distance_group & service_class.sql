USE AirtravelSilver
GO

--- Distance_Group -- 

INSERT INTO Distance_Group (
    BK_Code,
    [DESCRIPTION]
)
SELECT 
    BK_Code,
    [DESCRIPTION]
FROM v_Distance_Group;


--- AirCraft_Group -- 

INSERT INTO AirCraft_Group (
    BK_Code,
    [DESCRIPTION]
)
SELECT 
    BK_Code,
    [DESCRIPTION]
FROM v_Aircraft_Group;


--- SERVICE_CLASS --


INSERT INTO Service_Class (
    BK_Code,
    [DESCRIPTION]
)
SELECT 
    BK_Code,
    [DESCRIPTION]
FROM v_Service_Class;
