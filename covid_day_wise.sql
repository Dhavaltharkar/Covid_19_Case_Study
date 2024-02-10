use covid_19;
show tables;

-- Q1. What is the total number of confirmed cases?

SELECT SUM(Confirmed) AS totalconfirmed
FROM day_wise;

-- Q2. How many deaths has been reported so far?

SELECT
 SUM(Deaths) AS olddeaths,
 SUM(`New deaths`) AS newDeaths, 
 SUM(Deaths) + SUM(`New deaths`) AS OverallDeath
FROM day_wise;

-- Q3. What is the overall count of confirmed cases along with old and new cases total?
 
SELECT 
 SUM(`Confirmed`)  AS oldcases,
 SUM(`New cases`) AS newcases,
SUM(`Confirmed`) + SUM(`New cases`) AS OverallCases
FROM day_wise;


-- Q4. What is the totla number of active cases?

SELECT SUM(Active) FROM day_wise; 

-- Q5. What is the total recovered patient for each month in the year 2020 from day_wise data

SELECT 
  MONTH(Date) AS Month,
  SUM(Recovered) AS MonthlyRecoveries
FROM day_wise
GROUP BY MONTH(Date)
ORDER BY Month;

-- Q6. What is the recovery of the patient day wise in the month of July for 2020 year from day_wise dataset? 

SELECT 
 CONCAT( MONTH(Date), ':', Day(Date)) AS MonthDay,
  SUM(Recovered) AS MonthlyRecoveries
FROM day_wise
WHERE MONTH(Date) = 7
GROUP BY  MonthDay
ORDER BY  MonthDay;


-- Q7. Retrieve the monthly total deaths, along wth display month over month deaths and the difference between previous and current months? 

WITH Monthly AS (
    SELECT MONTHNAME(date) AS month, DATE_FORMAT(date, '%Y-%m') AS month_order,SUM(Deaths) AS MonthlyDeaths
    FROM day_wise
    GROUP BY month, month_order
    ORDER BY month_order
)
SELECT month,
	MonthlyDeaths,
	LAG(MonthlyDeaths, 1) OVER (ORDER BY month_order) AS Previous_MonthlyDeaths ,
    MonthlyDeaths - LAG(MonthlyDeaths, 1) OVER (ORDER BY month_order) AS monthly_difference
FROM Monthly;
