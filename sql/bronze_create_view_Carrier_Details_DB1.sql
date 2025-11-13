--- Carrier Details Intermeridary table (for DB1) -- 


CREATE OR ALTER VIEW v_Carrier_Details_DB1 AS (
SELECT 
    AIRLINE_ID,
    UNIQUE_CARRIER,
    UNIQUE_CARRIER_NAME,
    WAC,
    START_DATE_SOURCE
FROM (
    SELECT 
        AIRLINE_ID,
        UNIQUE_CARRIER,
        UNIQUE_CARRIER_NAME,
        WAC,
        START_DATE_SOURCE,
        ROW_NUMBER() OVER (
            PARTITION BY UNIQUE_CARRIER 
            ORDER BY TRY_CAST(START_DATE_SOURCE AS DATE) DESC
        ) AS rn
    FROM T_CARRIER_DECODE
    WHERE UNIQUE_CARRIER IS NOT NULL
) AS ranked
WHERE rn = 1
)


