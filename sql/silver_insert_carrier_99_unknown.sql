USE [AirtravelSilverTest]
GO

INSERT INTO [dbo].[Carriers]
           ([BK_UNIQUE_CARRIER]
           ,[AIRLINE_ID]
           ,[UNIQUE_CARRIER_NAME]
           ,[WAC]
           ,[START_DATE_SOURCE])
     VALUES
           ('99'
           ,'99999'
           ,'Unknown Carrier'
           ,999
           ,GETDATE())
GO


