
use AirtravelSilver
GO


---- Distance_Group_DIM Table ----


CREATE TABLE Distance_Group (
    BK_Code INT CONSTRAINT PK_Code_Distance_Group PRIMARY KEY,
    [DESCRIPTION] NVARCHAR(255)
);



---- AirCraft_Group_DIM Table ----


CREATE TABLE AirCraft_Group (
      BK_Code INT CONSTRAINT PK_Code_AirCraft_Group PRIMARY KEY
    , [DESCRIPTION] NVARCHAR(255))

---- Service_Class_DIM Table ----


CREATE TABLE Service_Class (
      BK_Code NVARCHAR (3) CONSTRAINT PK_Code_Service_Class_DIM PRIMARY KEY
    , [DESCRIPTION] NVARCHAR(255))
