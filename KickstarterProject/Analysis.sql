--  Analysis --
-- Getting the number of projects in each state --
select  state, count(state) as status
from 2018starter 
group by state;

-- Getting the number of backers per category --
select category, count(backers) as Investors
from 2018starter
group by category;

-- Total number of categories --
select count(distinct(category)) as totalNumberOfCategories
from 2018starter;

-- Getting the total number of projects in each category --
select category, count(name) as projects
from 2018starter
group by category;

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
select distinct(country), count(distinct(name)) as totalNumberOfProjects
from 2018starter
group by country;

-- Number of country per category --
select category, count(distinct(country)) as totalNumberOfCountries
from 2018starter
group by category;

-- Failed projects -- 
select * from 2018starter 
where state ='failed';

-- Goal set for failed projects-- 
select goal, count(ID) as projects
from 2018starter where state = 'failed'
group by goal;

-- Categories of failed projects --
select category, count(ID) as projects
from 2018starter where state = 'failed'
group by category
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

-- Categories of successful projects --
select category, count(ID) as projects
from 2018starter where state = 'successful'
group by category
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

-- Analyze countries, categories and duration with the highest number of failed and successful projects --
select country, count(ID) as projects
from 2018starter
where state = 'successful'
group by country
order by projects desc
limit 5;

-- what is the goal and pledged and backers for the top five successful and failed projects in countries, categories and projectduration --

-- Canceled projects --
select * from 2018starter
where state = 'canceled';

-- Live projects --
select * from 2018starter 
where state = 'live';

-- Suspended projects --
select * from 2018starter
where state = 'suspended';
