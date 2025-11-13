USE AirtravelBronze
GO

--- L_AIRCRAFT_GROUP Data --- 

CREATE TABLE L_AIRCRAFT_GROUP (
    Code nvarchar (50)
    , DESCRIPTION NVARCHAR(255)

)


TRUNCATE TABLE dbo.L_AIRCRAFT_GROUP;

BULK INSERT dbo.L_AIRCRAFT_GROUP
FROM 'C:\Users\stgadmin\Project\L_AIRCRAFT_GROUP.csv'
WITH
(
    FIRSTROW = 2,                  -- skip header
    FIELDTERMINATOR = ',',         -- comma-separated
    ROWTERMINATOR = '\n',          -- new line ends each row
    TABLOCK
)

UPDATE dbo.L_AIRCRAFT_GROUP
SET Code = LTRIM(RTRIM(REPLACE(Code, '"', '')));

SELECT * 
FROM dbo.L_AIRCRAFT_GROUP;


ALTER TABLE dbo.L_AIRCRAFT_GROUP
ALTER COLUMN Code INT;



---- L_AIRCRAFT_TYPE DATA ---- 


CREATE TABLE L_AIRCRAFT_TYPE_TABLE (
    Code INT 
    , DESCRIPTION NVARCHAR(255)

)

ALTER TABLE dbo.L_AIRCRAFT_TYPE_TABLE
ALTER COLUMN Code NVARCHAR(50);

TRUNCATE TABLE dbo.L_AIRCRAFT_TYPE_TABLE;

BULK INSERT dbo.L_AIRCRAFT_TYPE_TABLE
FROM 'C:\Users\stgadmin\Project\air-travel-dwh\Data\L_AIRCRAFT_TYPE.csv'
WITH
(
    FIRSTROW = 2,                  -- skip header
    FIELDTERMINATOR = ',',         -- comma-separated
    ROWTERMINATOR = '\n',          -- new line ends each row
    TABLOCK
)

UPDATE dbo.L_AIRCRAFT_TYPE_TABLE
SET Code = LTRIM(RTRIM(REPLACE(Code, '"', '')));


ALTER TABLE dbo.L_AIRCRAFT_TYPE_TABLE
ALTER COLUMN Code INT;

SELECT * 
FROM dbo.L_AIRCRAFT_TYPE_TABLE;

---- L_DISTANCE_GROUP_500 DATA ---- 


CREATE TABLE L_DISTANCE_GROUP_500 (
    Code NVARCHAR(50) 
    , DESCRIPTION NVARCHAR(255)

)

TRUNCATE TABLE dbo.L_DISTANCE_GROUP_500;

BULK INSERT dbo.L_DISTANCE_GROUP_500
FROM 'C:\Users\stgadmin\Project\air-travel-dwh\Data\L_DISTANCE_GROUP_500.csv'
WITH
(
    FIRSTROW = 2,                  -- skip header
    FIELDTERMINATOR = ',',         -- comma-separated
    ROWTERMINATOR = '\n',          -- new line ends each row
    TABLOCK
)

UPDATE dbo.L_DISTANCE_GROUP_500
SET Code = LTRIM(RTRIM(REPLACE(Code, '"', '')));


ALTER TABLE dbo.L_DISTANCE_GROUP_500
ALTER COLUMN Code INT;

SELECT * 
FROM dbo.L_DISTANCE_GROUP_500;




---- L_SERVICE_CLASS DATA ---- 


CREATE TABLE L_SERVICE_CLASS (
    Code NVARCHAR(50) 
    , DESCRIPTION NVARCHAR(255)

)

TRUNCATE TABLE dbo.L_SERVICE_CLASS;

BULK INSERT dbo.L_SERVICE_CLASS
FROM 'C:\Users\stgadmin\Project\air-travel-dwh\Data\L_SERVICE_CLASS.csv'
WITH
(
    FIRSTROW = 2,                  -- skip header
    FIELDTERMINATOR = ',',         -- comma-separated
    ROWTERMINATOR = '\n',          -- new line ends each row
    TABLOCK
)

UPDATE dbo.L_SERVICE_CLASS
SET Code = LTRIM(RTRIM(REPLACE(Code, '"', '')));


SELECT * 
FROM dbo.L_SERVICE_CLASS;
