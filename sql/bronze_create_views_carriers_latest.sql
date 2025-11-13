USE [AirtravelBronze2]
GO

/****** Object:  View [dbo].[v_Carriers_Latest]    Script Date: 29-10-25 11:21:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   view [dbo].[v_Carriers_Latest]
AS
SELECT
    AIRLINE_ID,
    CARRIER,
    CARRIER_ENTITY,
    CARRIER_NAME,
    UNIQUE_CARRIER,
    UNIQUE_CARRIER_ENTITY,
    UNIQUE_CARRIER_NAME,
    WAC,
    CARRIER_GROUP,
    CARRIER_GROUP_NEW,
    REGION,
    START_DATE_SOURCE,
    THRU_DATE_SOURCE
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY UNIQUE_CARRIER_ENTITY
                ORDER BY
                    CASE WHEN THRU_DATE_SOURCE IS NULL THEN 0 ELSE 1 END, -- Priorité 1: Les NULL en premier (0 < 1)
                    THRU_DATE_SOURCE DESC -- Priorité 2: Ensuite, les dates les plus récentes (DESC)
            ) AS rn
        FROM
            T_CARRIER_DECODE
    ) AS RankedData
WHERE
rn = 1
GO

