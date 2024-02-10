use covid_19;

ALTER TABLE country_wise
RENAME COLUMN `Country/Region` TO `Country`;

select * from country_wise;

-- Q1. Which country has the highest number of confirmed cases?

SELECT Country, Confirmed 
FROM country_wise
ORDER BY Confirmed DESC
LIMIT 1;

-- Q2. Identify the country with highest overall deaths total?

SELECT Country, SUM(Deaths + `New deaths`) AS OverallDeaths
FROM country_wise
GROUP BY Country
ORDER BY OverallDeaths DESC
LIMIT 1;


-- Q3.. Find the country with lowest nymber of active cases?

SELECT Country, MAX(Recovered) AS Cure
FROM country_wise
GROUP BY Country
ORDER BY Cure DESC
LIMIT 5;

-- Q4. Identidy the countrywise with highest totsl number of new deaths?

SELECT Country, SUM(Newdeaths) AS COUNT_Deaths
FROM country_wise
GROUP BY Country
ORDER BY COUNT_Deaths DESC
LIMIT 5;


-- Q5. Region wise Confirmed Cases, Deaths, Recovery of a patient, and Active Cases?

SELECT `WHO Region`, 
       SUM(Confirmed) AS confirmcases, 
       SUM(Deaths) AS deathcount, 
       SUM(Recovered) AS Cured, 
       SUM(Active) AS activelycases
FROM country_wise
GROUP BY `WHO Region`
ORDER BY `WHO Region`;
