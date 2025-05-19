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


-- Total projects, Successprojects, Failed Projects, and Success and Failure rate by category --
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


-- Success and Failure rate by Goal ranges --
select 
GoalRangeAmount, GoalRange, 
count(*) as TotalProjects,
 sum(case when state = 'successful' then 1 else 0 end) as successful_projects,
  sum(case when state = 'failed' then 1 else 0 END) as failed_projects,
  round(100.0 * sum(case when state = 'successful' then 1 else 0 end) / count(*), 0) as SuccessRate, 
  round(100.0* SUM(case when state = 'failed' then 1 else 0 end)/ count(*), 0) as FailureRate
from ( 
select goal, state,
   case
       when goal <= 1000 then '0 - 1000'
       when goal >1000 and goal <= 5000 then '1001 - 5000'
       when goal > 5000 and goal <= 10000 then '50001 - 10000'
       when goal > 10000 and goal <= 50000 then '10001 - 50,000'
       else '500001 and above' end as GoalRangeAmount,

   case
       when goal <= 1000 then 'Very Low Goal'
       when goal >1000 and goal <= 5000 then 'Low Goal'
       when goal > 5000 and goal <= 10000 then 'Medium Goal'
       when goal > 10000 and goal <= 50000 then 'High Goal'
       else 'Very High Goal' end as GoalRange
from 2018starter) as subquery
group by  GoalRangeAmount, GoalRange
order by GoalRange;








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
select id, name, goal, backers, pledged,
case when
     (case when goal <= 10163 then 1 else 0 end + 
     case when backers >= 264 then 1 else 0 end + 
     case when pledged >= 67347 then 1 else 0 end +
     case when pledged >= goal then 1 else 0 end) >=1
    then 'likely to Succeed'
    else 'Not likely to Succeed'
    end as "Succeed Prediction"
from 2018starter;
