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
select distinct(category), count(distinct(country)) as totalNumberOfCountries
from 2018starter
group by category;

