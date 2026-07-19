-- Databricks notebook source
-- Viewership by hour, weekday/weekend, peak viewing time, show ages, gender, and province
SELECT
    COALESCE(A.UserID0, A.userid4) AS UserID,
    A.RecordDate2 AS record_date,
    B.name,
    B.Surname,
    B.Email,
    B.Gender,
    B.Race,
    B.Age,
    B.`Social Media Handle`,
    B.Province,
    HOUR(A.RecordDate2) AS view_hour,
    DAYOFWEEK(A.RecordDate2) AS day_number,
    DATE_FORMAT(A.RecordDate2, 'EEEE') AS day_name,
    CASE
        WHEN DAYOFWEEK(A.RecordDate2) IN (7,1) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_classification,
    COUNT(*) AS view_count,
    CASE
        WHEN HOUR(A.RecordDate2) BETWEEN 18 AND 21 THEN 'Peak'
        ELSE 'Off-Peak'
    END AS peak_viewing_time,
    ROUND(Hour(A.`Duration 2`) * 60 + minute(A.`Duration 2`) + second(A.`Duration 2`) / 60, 2) AS duration_minute
FROM `agent_assignment`.`portfolio`.`Viewership` A
LEFT JOIN `agent_assignment`.`portfolio`.`bright_tv` B
  ON COALESCE(A.UserID0, A.userid4) = B.UserID
GROUP BY
    COALESCE(A.UserID0, A.userid4),
    A.RecordDate2,
    B.name,
    B.Surname,
    B.Email,
    B.Gender,
    B.Race,
    B.Age,
    B.`Social Media Handle`,
    B.Province,
    HOUR(A.RecordDate2),
    DAYOFWEEK(A.RecordDate2),
    DATE_FORMAT(A.RecordDate2, 'EEEE'),
    CASE
        WHEN DAYOFWEEK(A.RecordDate2) IN (7,1) THEN 'Weekend'
        ELSE 'Weekday'
    END,
    CASE
        WHEN HOUR(A.RecordDate2) BETWEEN 18 AND 21 THEN 'Peak'
        ELSE 'Off-Peak'
    END,
    A.`Duration 2`;

-- COMMAND ----------


