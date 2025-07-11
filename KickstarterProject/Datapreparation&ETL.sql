-- Kickstarter Project Data Preparatiin and cleaning --

-- 1. Creating the datababse and the table and the column headings with their datatype --
create database starter;
use starter;
create table `2018starter` (ID int, name text, category text, main_category text, currency text,
deadline text, goal text, launched text, pledged text, state text, backers text, country text, 
`usd pledged` text, usd_pledged_real text, usd_goal_real text);

-- 2.  importing the table 2018starter csv file --
set global local_infile=on;
load data local infile '/Users/user/Downloads/ks-projects-201801.csv'
into table `2018starter`
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

-- 3. Finding Incorrect Values in each columns --
-- A. Incorrect Values in ID column --
-- should return empty if there are no text values in the column --
select * from 2018starter
where ID NOT regexp '^[0-9]+$'; 

-- Returns empty if there are no blank spaces or null values --
select * from 2018starter
where ID is null OR ID = ''; 

-- B. Incorrect Values in name column --
-- Returns empty if there are no blank spaces or null values --
select * from 2018starter
where name is null OR name = ''; 

-- C. Incorrect Values in main_category column --
-- check all the distinct maincategories present in the column to detect any incorrect terms--
select distinct(main_category) from 2018starter;
 
-- will return values with this values as they are currency values and returns empty once fixed --
select * from `2018starter`
where main_category in  ('USD', 'GBP'); 

-- D. Incorrect Values in currency column --
-- returns empty if there are no blank spaces or null values --
select* from `2018starter` where currency is null or currency = ''; 

 -- check all the distinct currency present in the column to detect any incorrect values--
select distinct(currency) from 2018starter;

-- returns the details for the currency column with the date values and will return empty once fixed--
select * from `2018starter` 
where currency in ('2015-04-06', '2015-05-12', '2015-03-08'); 

-- E. Incorrect Values in goal column --
-- returns empty if there are no blank spaces or null values --
select* from `2018starter` where goal is null or goal = ''; 

-- returns values in this column that is not a number format and returns empty once fixed--
select * from `2018starter`
where goal NOT REGEXP '^[0-9]+(\.[0-9]+)?$';

-- F. Incorrcet Values in Deadline --
-- returns empty if there are no blank spaces or null values --
select* from `2018starter` where deadline is null or deadline = ''; 

-- returns values that are not dates regardless of the date format used and returns empty once fixed --
select * from 2018starter
where deadline not regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
  and deadline not regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
  and deadline not regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
  and deadline not regexp '^[0-9]{4}/[0-9]{2}/[0-9]{2}$';


-- F. Incorrcet Values in launched --
-- returns empty if there are no blank spaces or null values --
select* from `2018starter` where launched is null or launched = ''; 

-- returns values that are not dates regardless of the date format used and returns empty once fixed --
select * from 2018starter
where launched not regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}( [0-9]{2}:[0-9]{2}(:[0-9]{2})?)?$'
  and launched not regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4}( [0-9]{2}:[0-9]{2}(:[0-9]{2})?)?$'
  and launched not regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}( [0-9]{2}:[0-9]{2}(:[0-9]{2})?)?$'
  and launched not regexp '^[0-9]{4}/[0-9]{2}/[0-9]{2}( [0-9]{2}:[0-9]{2}(:[0-9]{2})?)?$';


-- G. Incorrect Values in pledged column --
-- returns empty if there are no blank spaces or null values --
select* from `2018starter` where pledged is null or pledged = ''; 

 -- returns values in this column that is not a number format and returns empty once fixed--
select * from `2018starter`
where pledged not regexp '^[0-9]+(\.[0-9]+)?$';

-- H. Incorrect Values in State Column --
-- Returns empty if there are no blank spaces or null values --
select * from 2018starter where state is null OR state = '';

-- check all the distinct states present in the column to detect any incorrect terms-- 
select distinct(state) from 2018starter; 

 -- selects and shows the incorrect values in state column, returns empty once fixed --
select * from 2018starter where state regexp '^[0-9]+(\.[0-9]+)?$';

-- I. Incorrect Values in backers Column --
-- Returns empty if there are no blank spaces or null values --
select * from 2018starter where backers is null OR backers = '';

 -- returns values in this backers column that is not a number format and returns empty once fixed--
select * from `2018starter`
where backers not regexp '^[0-9]+(\.[0-9]+)?$';

-- J. Incorrect Values in country Column --
-- check all the distinct countries present in the column to detect any incorrect terms-- 
select distinct(country) from 2018starter; 

-- Returns empty if there are no blank spaces or null values --
select * from 2018starter where country is null OR country = '';

-- checks for incorrect values and returns empty once fixed --
select * from 2018starter where country regexp '^[0-9]+(\.[0-9]+)?$';

-- J. Incorrect Values in usd pledged Column --
select* from `2018starter` where `usd pledged` is null or `usd pledged` = ''; 
 -- returns values in this column that is not a number format and returns empty once fixed--
select * from `2018starter`
where `usd pledged` not regexp '^[0-9]+(\.[0-9]+)?$';

-- K. Incorrect Values in usd pledged real Column --
-- Returns null values or blank spaces, and returns empty once fixed --
select* from `2018starter` where usd_pledged_real is null or usd_pledged_real = ''; 

-- checks for incorrect values and returns empty once fixed --
select * from `2018starter`
where usd_pledged_real not regexp '^[0-9]+(\.[0-9]+)?$';

-- L. Incorrect Values in usd pledged goal Column --
-- returns empty once fixed --
select* from `2018starter` where usd_goal_real is null or usd_goal_real = '';

-- checks for incorrect values and returns empty once fixed --
select * from `2018starter`
where usd_goal_real not regexp '^[0-9]+(\.[0-9]+)?$';

-- 4. From the checks above, values in column with ID 1105671266, 2054476698, 96887393, are the ones with incorrect values -- 
-- FIXING the incorrect values for the three rows with ID 1105671266, 2054476698, 96887393 --
set SQL_SAFE_UPDATES = 0;
-- For ID = 1105671266
select
    main_category, currency, deadline, goal, launched, pledged,
    state, backers, country, `usd pledged`, usd_pledged_real
into 
    @temp_main_category, @temp_currency, @temp_deadline, @temp_goal, @temp_launched, @temp_pledged,
    @temp_state, @temp_backers, @temp_country, @temp_usd_pledged, @temp_usd_pledged_real
from 2018starter
where ID = 1105671266;
update 2018starter
set 
    main_category = category,
    currency = @temp_main_category,
    deadline = @temp_currency,
    goal = @temp_deadline,
    launched = @temp_goal,
    pledged = @temp_launched,
    state = @temp_pledged,
    backers = @temp_state,
    country = @temp_backers,
    `usd pledged` = @temp_country,
    usd_pledged_real = @temp_usd_pledged,
    usd_goal_real = @temp_usd_pledged_real
where ID = 1105671266;

-- For ID = 2054476698
select 
    main_category, currency, deadline, goal, launched, pledged,
    state, backers, country, `usd pledged`, usd_pledged_real
into 
    @temp_main_category, @temp_currency, @temp_deadline, @temp_goal, @temp_launched, @temp_pledged,
    @temp_state, @temp_backers, @temp_country, @temp_usd_pledged, @temp_usd_pledged_real
from 2018starter
where ID = 2054476698;
update 2018starter
set
    main_category = category,
    currency = @temp_main_category,
    deadline = @temp_currency,
    goal = @temp_deadline,
    launched = @temp_goal,
    pledged = @temp_launched,
    state = @temp_pledged,
    backers = @temp_state,
    country = @temp_backers,
    `usd pledged` = @temp_country,
    usd_pledged_real = @temp_usd_pledged,
    usd_goal_real = @temp_usd_pledged_real
where ID = 2054476698;

-- For ID = 96887393
select 
    main_category, currency, deadline, goal, launched, pledged,
    state, backers, country, `usd pledged`, usd_pledged_real
into 
    @temp_main_category, @temp_currency, @temp_deadline, @temp_goal, @temp_launched, @temp_pledged,
    @temp_state, @temp_backers, @temp_country, @temp_usd_pledged, @temp_usd_pledged_real
from 2018starter
where ID = 96887393;
update 2018starter
set 
    main_category = category,
    currency = @temp_main_category,
    deadline = @temp_currency,
    goal = @temp_deadline,
    launched = @temp_goal,
    pledged = @temp_launched,
    state = @temp_pledged,
    backers = @temp_state,
    country = @temp_backers,
    `usd pledged` = @temp_country,
    usd_pledged_real = @temp_usd_pledged,
    usd_goal_real = @temp_usd_pledged_real
where ID = 96887393;
set SQL_SAFE_UPDATES = 1;

-- To check the values for the three rows after the fix --
select * FROM 2018starter
where id in (1105671266, 2054476698, 96887393);

-- 5. columns with undefined state, have blank spaces in the usd pledged column --
-- To fix replacing blank spaces and null with zero -- 
-- For usd pledged real column --
set SQL_SAFE_UPDATES = 0;
update 2018starter
set usd_pledged_real = 0 
where usd_pledged_real is null;
set SQL_SAFE_UPDATES = 1;

-- For usd pledged column --
set SQL_SAFE_UPDATES = 0;
update 2018starter
set `usd pledged` = 0 
where TRIM(`usd pledged`) = '' or `usd pledged` is null;
set SQL_SAFE_UPDATES = 1;

-- 6. Fix deadline and launched date format  to a standardized format--
-- Standardizing the date format for deadline column --
set sql_safe_updates = 0;

update 2018starter
set launched = case
    -- handles formats like: 12/31/2020 14:30:59 or 12/31/2020 14:30
    when launched regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}(:[0-9]{2})?$' 
    then date_format(str_to_date(launched, '%m/%d/%Y %H:%i:%s'), '%Y-%m-%d %H:%i:%s')

    -- handles formats like: 31-12-2020 09:15:05 or 31-12-2020 09:15
    when launched regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4} [0-9]{2}:[0-9]{2}(:[0-9]{2})?$'
        then date_format(str_to_date(launched, '%d-%m-%Y %H:%i:%s'), '%Y-%m-%d %H:%i:%s')

    -- handles formats like: 2020-12-31 12:00:00 or 2020-12-31 12:00
    when launched regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}(:[0-9]{2})?$'
        then date_format(str_to_date(launched, '%Y-%m-%d %H:%i:%s'), '%Y-%m-%d %H:%i:%s')

    else launched
end;

set sql_safe_updates = 1;


-- 7. Standardizing the date format for launched column --
set sql_safe_updates = 0;
update 2018starter
set launched = case
    -- Format: MM/DD/YYYY HH:MM:SS
    when launched regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}$' then date_format(str_to_date(launched, '%m/%d/%Y %H:%i:%s'), '%Y-%m-%d %H:%i:%s')
    -- Format: MM/DD/YYYY HH:MM
    when launched regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}$' then date_format(str_to_date(launched, '%m/%d/%Y %H:%i'), '%Y-%m-%d %H:%i:00')
    -- Format: DD/MM/YYYY HH:MM:SS
    when launched regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}$' then date_format(str_to_date(launched, '%d/%m/%Y %H:%i:%s'), '%Y-%m-%d %H:%i:%s')
    -- Format: DD/MM/YYYY HH:MM
    when launched regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}$' then date_format(str_to_date(launched, '%d/%m/%Y %H:%i'), '%Y-%m-%d %H:%i:00')
    -- Format: MM-DD-YYYY HH:MM:SS
    when launched regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}$' then date_format(str_to_date(launched, '%m-%d-%Y %H:%i:%s'), '%Y-%m-%d %H:%i:%s')
    -- Format: MM-DD-YYYY HH:MM
    when launched regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4} [0-9]{2}:[0-9]{2}$' then date_format(str_to_date(launched, '%m-%d-%Y %H:%i'), '%Y-%m-%d %H:%i:00')
    -- Format: DD-MM-YYYY HH:MM:SS
    when launched regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}$' then date_format(str_to_date(launched, '%d-%m-%Y %H:%i:%s'), '%Y-%m-%d %H:%i:%s')
    -- Format: DD-MM-YYYY HH:MM
    when launched regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4} [0-9]{2}:[0-9]{2}$' then date_format(str_to_date(launched, '%d-%m-%Y %H:%i'), '%Y-%m-%d %H:%i:00')
    -- Format: YYYY-MM-DD HH:MM:SS (already good)
    when launched regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$' then launched
    -- Format: YYYY-MM-DD HH:MM
    when launched regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}$' then concat(launched, ':00')
    -- Anything else (unrecognized format)
    else null
end;
set sql_safe_updates = 1;

select launched from 2018starter;

-- 8. Fixing the data type  for each column in 2018starter table to ensure quality and consistency--
set SQL_SAFE_UPDATES = 0;
alter table `2018starter` modify column deadline date;
alter table `2018starter` modify column launched datetime;
alter table `2018starter` modify column goal int;
alter table `2018starter` modify column `usd pledged` double;
alter table `2018starter` modify column pledged double;
alter table `2018starter` modify column backers int;
alter table `2018starter` modify column usd_pledged_real double;
alter table `2018starter` modify column usd_goal_real double;
set SQL_SAFE_UPDATES = 1;

-- 9. Permanently adding new columns for the launchDate and launchTime to both tables --
alter table 2018starter 
add column launchDate date, 
add column launchTime time;

-- 10. Extracting Date and time from Launched Time frame into the new columns created --
set SQL_SAFE_UPDATES = 0; 
update 2018starter
set launchDate = date(launched),
    launchTime = time(launched);
set SQL_SAFE_UPDATES = 1; 

-- Round up number values to a whole number --
set SQL_SAFE_UPDATES = 0; 
update 2018starter 
set pledged= round(pledged, 0),
`usd pledged` = round(`usd pledged`, 0),
usd_pledged_real = round(usd_pledged_real, 0),
usd_goal_real = round(usd_goal_real, 0);
set SQL_SAFE_UPDATES = 1;

-- Preview what the table would look like with the new column and calculated values --
select *,
       DATEDIFF(deadline, launchDate) AS projectDurationPreview
FROM 2018starter;

-- Adding a New Column for Project period in days --
alter table 2018starter 
add column projectdurationDays int;
set SQL_SAFE_UPDATES = 0;
update 2018starter
set projectdurationDays = datediff(deadline, launchDate);
set SQL_SAFE_UPDATES = 1;

select* from 2018starter; 

--  Adding new column for LaunchMonth, Launchyear, deadlinemonth, deadlineyear and launchseason --
alter table 2018starter
add column launchmonth int,
add column launchyear int,
add column deadlinemonth int,
add column deadlineyear int,
add column launchseason varchar(20);

-- Updating new column for LaunchMonth, Launchyear, deadlinemonth, deadlineyear --
set SQL_SAFE_UPDATES = 0;
update 2018starter
set 
  launchmonth = month(launched),
  launchyear = year(launched),
  deadlinemonth = month(deadline),
  deadlineyear = year(deadline),
  launchseason = case
  when month(launched) in (12, 1, 2) then 'Winter'
  when month(launched) in (3, 4, 5) then 'Spring'
  when month(launched) in (6, 7, 8) then 'Summer'
  when month(launched) in (9, 10, 11) then 'Fall'
  else 'Unknown'
end;  
set SQL_SAFE_UPDATES = 1;

-- Add new columns Month name --
alter table 2018starter
add column launch_month_name varchar(20),
add column deadline_month_name varchar(20);

-- Update columns Monthname for Launched and Deadline --
set SQL_SAFE_UPDATES = 0;
update 2018starter
set 
  launch_month_name = monthname(launched),
  deadline_month_name = monthname(deadline);
set SQL_SAFE_UPDATES = 1;

select* from 2018starter; 
