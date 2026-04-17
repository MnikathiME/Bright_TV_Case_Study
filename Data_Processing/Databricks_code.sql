--Checking all rows and columns and explore data
SELECT *
FROM `bright`.`tv_sales`.`table1` AS A
FULL OUTER JOIN `bright`.`tv_sales`.`table2` AS B
ON `A`.`UserID` = `B`.`UserID0`;

--Checking dates of data, from when to when
SELECT MIN(RecordDate2)AS Start_Date
FROM `bright`.`tv_sales`.`table1` AS A
FULL OUTER JOIN `bright`.`tv_sales`.`table2` AS B
ON `A`.`UserID` = `B`.`UserID0`;

SELECT MAX(RecordDate2)AS Start_Date
FROM `bright`.`tv_sales`.`table1` AS A
FULL OUTER JOIN `bright`.`tv_sales`.`table2` AS B
ON `A`.`UserID` = `B`.`UserID0`;

-- Checking number of rows and unique UserIDs
SELECT COUNT(DISTINCT *) AS All_Users,
       COUNT(DISTINCT A.UserID) AS Users
FROM `bright`.`tv_sales`.`table1` AS A
FULL OUTER JOIN `bright`.`tv_sales`.`table2` AS B
ON `A`.`UserID` = `B`.`UserID0`;

------------------------------------------------------------------------------------------------

-- Checking all columns and matching rows using INNER JOIN--
SELECT 
      A.UserID,

IFNULL (A.Province, 'No_Province') AS Province,
IFNULL (A.Gender, 'No_Gender') AS Gender,
IFNULL (A.Race, 'No_Race') AS Race,
IFNULL (A.Age, 'No_Age') AS Age,
IFNULL (B.Channel2, 'Not_Provided') AS Channel,
 -- Age Group Classification
    CASE 
        WHEN A.Age <=13 THEN 'Children'
        WHEN A.Age BETWEEN 14 AND 19 THEN 'Teenager'
        WHEN A.Age BETWEEN 20 AND 60 THEN 'Adult'
        ELSE 'Old_Age'
    END AS Age_Group,

-- Fix RecordDate2: Convert to South African timezone and separate date/time
    DATE(from_utc_timestamp(B.RecordDate2, 'Africa/Johannesburg')) AS Record_Date,
    DATE_FORMAT(from_utc_timestamp(B.RecordDate2, 'Africa/Johannesburg'), 'HH:mm:ss') AS Record_Time,
     -- Time of Day Classification
    CASE 
        WHEN HOUR(from_utc_timestamp(B.RecordDate2, 'Africa/Johannesburg')) BETWEEN 00 AND 11 THEN 'Morning'
        WHEN HOUR(from_utc_timestamp(B.RecordDate2, 'Africa/Johannesburg')) BETWEEN 12 AND 15 THEN 'Midday'
        WHEN HOUR(from_utc_timestamp(B.RecordDate2, 'Africa/Johannesburg')) BETWEEN 16 AND 19 THEN 'Afternoon'
        ELSE 'Night'
    END AS Time_Of_Day,

    -- Duration Date and Time (South African timezone)
    DATE_FORMAT(from_utc_timestamp(B.`Duration 2`, 'Africa/Johannesburg'), 'HH:mm:ss') AS Duration_Time,

    --View Date
    DAYNAME(from_utc_timestamp(B.RecordDate2, 'Africa/Johannesburg')) AS Day_Name,
    MONTHNAME(from_utc_timestamp(B.RecordDate2, 'Africa/Johannesburg')) AS Month_Name

FROM `bright`.`tv_sales`.`table1` AS A
FULL OUTER JOIN `bright`.`tv_sales`.`table2` AS B
ON `A`.`UserID` = `B`.`UserID0`;

