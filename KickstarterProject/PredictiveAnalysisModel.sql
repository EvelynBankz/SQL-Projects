-- Predictive Analysis Model -- 
-- Total projects, Successprojects, Failed Projects, and Success and Failure rate by country --
SELECT 
  country,
  count(*) as total_projects,
  sum(case when state = 'successful' then 1 else 0 end) as successful_projects,
  sum(case when state = 'failed' then 1 else 0 END) as failed_projects,
  round(100.0 * sum(case when state = 'successful' then 1 else 0 end) 
  / count(*), 0) as SuccessRate, 
  round(100.0* SUM(case when state = 'failed' then 1 else 0 end)/ count(*), 0) as FailureRate
from 2018starter
group by country
order by total_projects DESC;


-- Total projects, Successprojects, Failed Projects, and Success and Failure rate by main_category --
SELECT 
  main_category,
  count(*) as total_projects,
  sum(case when state = 'successful' then 1 else 0 end) as successful_projects,
  sum(case when state = 'failed' then 1 else 0 END) as failed_projects,
  round(100.0 * sum(case when state = 'successful' then 1 else 0 end) 
  / count(*), 0) as SuccessRate, 
  round(100.0* SUM(case when state = 'failed' then 1 else 0 end)/ count(*), 0) as FailureRate
from 2018starter
group by main_category
order by total_projects DESC;

-- Total projects, Successprojects, Failed Projects, and Success and Failure rate by launchmonthin maincategory -- 
select 
  main_category,
  launchyear,
  launch_month_name,
  count(*) as total_projects,
  sum(case when state = 'successful' then 1 else 0 end) as successful_projects,
  sum(case when state = 'failed' then 1 else 0 end) as failed_projects,
  round(100.0 * sum(case when state = 'successful' then 1 else 0 end) / count(*), 0) as success_rate,
  round(100.0 * sum(case when state = 'failed' then 1 else 0 end) / count(*), 0) as failure_rate
from 2018starter
group by main_category, launchyear, launch_month_name
order by 
  main_category,
  launchyear,
  field(launch_month_name, 'January','February','March','April','May','June','July','August','September','October','November','December');


-- Total projects, Successprojects, Failed Projects, and Success and Failure rate by launchmonth in Goal levels --
select 
  -- Goal range amount
  case
    when goal <= 1000 then '0 - 1000'
    when goal > 1000 and goal <= 5000 then '1001 - 5000'
    when goal > 5000 and goal <= 10000 then '5001 - 10000'
    when goal > 10000 and goal <= 50000 then '10001 - 50000'
    else '50001 and above'
  end as goal_range_amount,

  -- Goal level name
  case
    when goal <= 1000 then 'Very Low Goal'
    when goal > 1000 and goal <= 5000 then 'Low Goal'
    when goal > 5000 and goal <= 10000 then 'Medium Goal'
    when goal > 10000 and goal <= 50000 then 'High Goal'
    else 'Very High Goal'
  end as goal_level,

  launchyear,
  launch_month_name,
  count(*) as total_projects,
  sum(case when state = 'successful' then 1 else 0 end) as successful_projects,
  sum(case when state = 'failed' then 1 else 0 end) as failed_projects,
  round(100.0 * sum(case when state = 'successful' then 1 else 0 end) / count(*), 0) as success_rate,
  round(100.0 * sum(case when state = 'failed' then 1 else 0 end) / count(*), 0) as failure_rate

from 2018starter
group by goal_range_amount, goal_level, launchyear, launch_month_name
order by 
  goal_level,
  launchyear,
  field(launch_month_name, 'January','February','March','April','May','June','July','August','September','October','November','December');


-- Success and Failure rate by Goal ranges --
select  GoalRangeAmount, GoalRange, 
  count(*) as TotalProjects,
  sum(case when state = 'successful' then 1 else 0 end) as successful_projects,
  sum(case when state = 'failed' then 1 else 0 end) as failed_projects,
  round(100.0 * sum(case when state = 'successful' then 1 else 0 end) / count(*), 0) as SuccessRate, 
  round(100.0 * sum(case when state = 'failed' then 1 else 0 end) / count(*), 0) as FailureRate
from (
  select goal, state,
    case
      when goal <= 1000 then '0 - 1000'
      when goal > 1000 and goal <= 5000 then '1001 - 5000'
      when goal > 5000 and goal <= 10000 then '5001 - 10000'
      when goal > 10000 and goal <= 50000 then '10001 - 50,000'
      else '50001 and above' end as GoalRangeAmount,
    
    case
      when goal <= 1000 then 'Very Low Goal'
      when goal > 1000 and goal <= 5000 then 'Low Goal'
      when goal > 5000 and goal <= 10000 then 'Medium Goal'
      when goal > 10000 and goal <= 50000 then 'High Goal'
      else 'Very High Goal' end as GoalRange,
  
    case
      when goal <= 1000 then 1
      when goal > 1000 and goal <= 5000 then 2
      when goal > 5000 and goal <= 10000 then 3
      when goal > 10000 and goal <= 50000 then 4
      else 5 end as goal_range_order
    
  from 2018starter) as subquery
group by goal_range_order, GoalRangeAmount, GoalRange
order by goal_range_order;


-- Find AVERAGE Goal set for all successful projects and all failed projects -- 
-- Average Goal, Backers, and Pledged for Successful Projects--
select round(avg(goal)) as'Average Goal',
	   round(avg(backers)) as 'Average Backers', 
       round(avg(pledged)) as 'Average Pledged'
from 2018starter 
where state = 'successful';

-- Average Goal, Backers, and Pledged for Failed Projects --
select round(avg(goal)) as'Average Goal',
	   round(avg(backers)) as 'Average Backers', 
       round(avg(pledged)) as 'Average Pledged'
from 2018starter 
where state = 'failed';

-- Will Fail Yes/No Outcome --

-- Will Succeed Yes/No Outcome --
-- Model --
select id, name, goal, backers, pledged, state,
case when
     goal <= 10163 and backers > 1 and pledged >= goal
    then 'likely to Succeed'
    else 'Not likely to Succeed'
    end as "Succeed Prediction"
from 2018starter;

-- From Maincategory --
 select main_category, count(*) as total_projects,
  sum(case when succeed_prediction = 'likely to Succeed' then 1 else 0 end) as likely_success,
  sum(case when succeed_prediction = 'Not likely to Succeed' then 1 else 0 end) as likely_fail
from (
  select *, case 
      when goal <= 10163 and backers > 1 and pledged >= goal 
      then 'likely to Succeed' else 'Not likely to Succeed'
    end as succeed_prediction 
    from 2018starter) as prediction
group by main_category
order by likely_success desc;

-- From Country --
select country, count(*) as total_projects,
  sum(case when succeed_prediction = 'likely to Succeed' then 1 else 0 end) as likely_success,
  sum(case when succeed_prediction = 'Not likely to Succeed' then 1 else 0 end) as likely_fail
from (
  select *, case 
      when goal <= 10163 and backers > 1 and pledged >= goal 
      then 'likely to Succeed' else 'Not likely to Succeed'
    end as succeed_prediction 
    from 2018starter) as prediction
group by country
order by likely_success desc;

