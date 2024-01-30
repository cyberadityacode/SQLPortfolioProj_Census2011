SELECT * FROM Dataset1csv dc ;
SELECT * FROM Dataset2csv dc2 ;

-- number of rows in our dataset

SELECT COUNT(*) AS TotalRows FROM census_prj.Dataset1csv dc ;

SELECT COUNT(*) AS TotalRows FROM census_prj.Dataset2csv dc2 ;

-- Calculate Dataset of MP and Maharashtra
SELECT * FROM census_prj.Dataset1csv WHERE Dataset1csv.State in ('Maharashtra','Madhya Pradesh'); 

-- Calculate total population of India

SELECT SUM(Population) as Total_Population FROM Dataset2csv dc 


-- Calculate Average Growth of India - Descending Order

SELECT State, ROUND(AVG(Growth),2) AS Average_Growth   
FROM Dataset1csv dc 
GROUP BY State 
ORDER BY Average_Growth  DESC;

-- Average SEX RATIO 
-- Top 5 States with Highest Sex Ratio 

SELECT State , ROUND(AVG(Sex_Ratio)) AS Average_SexRatio
FROM Dataset1csv dc
GROUP BY State
ORDER BY Average_SexRatio DESC 
LIMIT 5;

-- Average Literacy Rate

SELECT State , ROUND(AVG(Literacy),2) as Literacy_Rate 
from Dataset1csv dc
GROUP BY State
ORDER BY Literacy_Rate DESC;

-- Top 5 States with Highest Literacy

SELECT State , ROUND(AVG(Literacy),2) as Literacy_Rate 
from Dataset1csv dc
GROUP BY State
ORDER BY Literacy_Rate DESC
LIMIT 5;


-- Top 5 States with Lowest Literacy

SELECT State , ROUND(AVG(Literacy),2) as Literacy_Rate 
from Dataset1csv dc
GROUP BY State
ORDER BY Literacy_Rate ASC 
LIMIT 5;

-- How many states with Literacy more than 90
 
SELECT State , ROUND(AVG(Literacy),2) as Literacy_Rate 
from Dataset1csv dc
GROUP BY State
HAVING  Literacy_Rate > 90
ORDER BY Literacy_Rate DESC;

-- How many states with Literacy less than 65%
 
SELECT State , ROUND(AVG(Literacy),2) as Literacy_Rate 
from Dataset1csv dc
GROUP BY State
HAVING  Literacy_Rate < 65
ORDER BY Literacy_Rate DESC;

-- Top 3 Highest Growth State

SELECT State ,ROUND(AVG(Growth),2) as Growth_of_State
from Dataset1csv dc 
group by State 
order by Growth_of_State DESC 
LIMIT 3;

-- Top 3 Lowest Growth State

SELECT State ,ROUND(AVG(Growth),2) as Growth_of_State
from Dataset1csv dc 
group by State 
order by Growth_of_State ASC  
LIMIT 3;


-- UNION ALL the Highest and Lowest Growth State
SELECT State ,ROUND(AVG(Growth),2) as Growth_of_State
from Dataset1csv dc 
group by State 
order by Growth_of_State DESC 
LIMIT 3;

SELECT State ,ROUND(AVG(Growth),2) as Growth_of_State
from Dataset1csv dc 
group by State 
order by Growth_of_State ASC  
LIMIT 3;


--
-- Combine top 3 and bottom 3 growth states
-- Combine top 3 and bottom 3 growth states
SELECT State, Growth_of_State
FROM (
    SELECT State, ROUND(AVG(Growth), 2) AS Growth_of_State
    FROM Dataset1csv dc
    GROUP BY State
    ORDER BY Growth_of_State DESC
    LIMIT 3
) AS top_states

UNION ALL

SELECT State, Growth_of_State
FROM (
    SELECT State, ROUND(AVG(Growth), 2) AS Growth_of_State
    FROM Dataset1csv dc
    GROUP BY State
    ORDER BY Growth_of_State ASC
    LIMIT 3
) AS bottom_states;

-- 

-- Union ALL CLOSE 


-- States starts with Letter a

SELECT  DISTINCT  State 
FROM Dataset1csv dc 
WHERE LOWER(State) LIKE 'a%';


-- How many States starts with Letter a

SELECT  COUNT(DISTINCT State) as State_With_Letter_A
FROM Dataset1csv dc 
WHERE LOWER(State) LIKE 'a%';



-- Day 2

SELECT * FROM Dataset1csv dc;
SELECT * FROM Dataset2csv dc ;

-- Calculate total male and female from two tables.
-- Join table
-- Formula for calculating no. of males
--  males = population/ (sex_ratio+1)
-- female = population - population/(sex_ratio+1)

-- Males Calc -- RAW DATA

Select cd.District, cd.State, cd.Population/(cd.sex_ratio+1) males,
(cd.Population* cd.sex_ratio)/(cd.sex_ratio +1 ) females
from 
(SELECT dc.District, dc.State, dc.Sex_Ratio , dc2.Population
from census_prj.Dataset1csv dc inner join census_prj.Dataset2csv dc2 
on dc.District  =dc2.District) cd 
WHERE cd.District ='Bhopal';


-- Calculate No. of Males, No. of Females from Population and Sex_Ratio
SELECT 
	cd.District, 
	cd.State, 
	((cd.Sex_Ratio)/(cd.Sex_Ratio+100))*cd.Population as Males_No ,
	cd.Population, 
	cd.Population - (((cd.Sex_Ratio)/(cd.Sex_Ratio+100))*cd.Population) as female_No,
	(((cd.Sex_Ratio)/(cd.Sex_Ratio+100))*cd.Population) + (cd.Population - (((cd.Sex_Ratio)/(cd.Sex_Ratio+100))*cd.Population)) as Total_Calc_Pop,
	cd.Sex_Ratio
from 
(SELECT dc.District, dc.State, dc.Sex_Ratio , dc2.Population
from census_prj.Dataset1csv dc inner join census_prj.Dataset2csv dc2 
on dc.District  =dc2.District) cd 
WHERE cd.State = 'Madhya Pradesh'
ORDER BY cd.Sex_Ratio DESC




















