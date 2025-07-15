-- Getting the number of projects in each state --
select  state, count(state) as status
from 2018starter 
group by state;

-- Getting the number of backers per main category --
select main_category, count(backers) as Investors
from 2018starter
group by main_category;

-- Total number of categories --
select count(distinct(main_category)) as totalNumberOfCategories
from 2018starter;

-- Getting the total number of projects in each  main category --
select main_category, count(id) as projects
from 2018starter
group by main_category;

-- Backers per Country --
select country, count(backers) as countryBackers
from 2018starter 
group by country;

-- Total pledgedrealusd per country --
select country, round(sum(usd_pledged_real), 0) as totalPledgedUSD
from 2018starter
group by country;

-- Total number of countries --
select count(distinct(country)) as totalNumberOfCountries
from 2018starter;

-- Number of projects per country --
select distinct(country), count(ID) as totalNumberOfProjects
from 2018starter
group by country;

-- Number of country per main category --
select main_category, count(distinct(country)) as totalNumberOfCountries
from 2018starter
group by main_category;

-- Failed projects -- 
select * from 2018starter 
where state ='failed';

-- Goal set for failed projects-- 
select goal, count(ID) as projects
from 2018starter where state = 'failed'
group by goal;

-- Main Categories of failed projects --
select main_category, count(ID) as projects
from 2018starter where state = 'failed'
group by main_category
order by projects desc;

-- Countries of failed projects --
select country, count(ID) as projects
from 2018starter where state = 'failed'
group by country
order by projects desc;

-- Project Duration of failed projects --
select projectdurationDays, count(ID) as projects
from 2018starter where state = 'failed'
group by projectdurationDays
order by projects desc;

-- Successful projects --
select * from 2018starter 
where state = 'successful';

-- Goal set for successful projects-- 
select distinct goal, count(ID) as projects
from 2018starter where state = 'successful'
group by goal
order by projects desc;

-- Main Categories of successful projects --
select main_category, count(ID) as projects
from 2018starter where state = 'successful'
group by main_category
order by projects desc;


-- Countries of successful projects --
select country, count(ID) as projects
from 2018starter where state = 'successful'
group by country
order by projects desc;

-- Project Duration of successful projects --
select projectdurationDays, count(ID) as projects
from 2018starter where state = 'successful'
group by projectdurationDays
order by projects desc;

-- Canceled projects --
select * from 2018starter
where state = 'canceled';

-- Live projects --
select * from 2018starter 
where state = 'live';

-- Suspended projects --
select * from 2018starter
where state = 'suspended';

-- Top 5 successful maincategory by projects  --
with subquery as
 (select main_category, count(ID) as projects
 from 2018starter
 where state = 'successful'
 group by main_category
 order by projects 
 limit 5)
select main_category, projects, rank() over(order by projects desc) as ranks from subquery;
  
-- Top 5 failed maincategory by projects  --
with subquery as
 (select main_category, count(ID) as projects
 from 2018starter
 where state = 'failed'
 group by main_category
 order by projects 
 limit 5)
select main_category, projects, rank() over(order by projects desc) as ranks from subquery;

-- Analyze countries, categories and duration with the highest number of failed and successful projects --
SELECT p.*
FROM `2018starter` p
JOIN (
    SELECT country
    FROM `2018starter`
    GROUP BY country
    ORDER BY COUNT(ID) DESC
    LIMIT 5
) AS top_countries ON p.country = top_countries.country
where state = 'successful';

SELECT p.*
FROM `2018starter` p
JOIN (
    SELECT country
    FROM `2018starter`
    GROUP BY country
    ORDER BY COUNT(ID) DESC
    LIMIT 5
) AS top_countries ON p.country = top_countries.country
where state = 'failed';
