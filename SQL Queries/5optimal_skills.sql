
/*
Question:
Combining the Query no.3 and no.4 to get the most optimal skills
which is (high demand and high paying skills)
*/


WITH skill_demand AS (
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skill_to_job.job_id) AS demand_count

FROM job_postings_fact
INNER JOIN skills_job_dim AS skill_to_job
    ON job_postings_fact.job_id = skill_to_job.job_id
INNER JOIN skills_dim
    ON skill_to_job.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = true
    AND salary_year_avg IS NOT NULL

GROUP BY
    skills_dim.skill_id


), average_salary AS (
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary

FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home = true

GROUP BY
    skills_dim.skill_id

)

SELECT
    skill_demand.skill_id,
    skill_demand.skills,
    demand_count,
    avg_salary

FROM
    skill_demand
INNER JOIN
    average_salary ON
    skill_demand.skill_id=average_salary.skill_id

WHERE
    demand_count > 10

ORDER BY
    avg_salary DESC,
    demand_count DESC

LIMIT 25



--rewriting in more concise query without using CTEs

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skill_to_job.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary

FROM
    job_postings_fact
INNER JOIN skills_job_dim as skill_to_job
    ON job_postings_fact.job_id = skill_to_job.job_id
INNER JOIN skills_dim
    ON skill_to_job.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL -- where can't use alias in conditions --
    AND job_work_from_home = True

GROUP BY
    skills_dim.skill_id

HAVING
    COUNT(skill_to_job.job_id) > 10 --having can't use alias in conditions--

ORDER BY
    average_salary DESC,
    demand_count DESC

LIMIT 25





/*

Sure! Here’s a concise summary of the insights:

- **High-paying roles favor cloud, big data, and engineering skills** like Go, 
    Snowflake, Hadoop, and AWS—indicating demand for analysts with modern data infrastructure knowledge.  
- **Core analytics tools** such as Python, SQL, R, and Tableau remain the most in-demand, 
    forming the foundation for most data analyst roles.  
- **Specialized or emerging tools** (e.g., BigQuery, Looker, Confluence) offer 
    premium salaries despite lower demand, making them valuable differentiators.

*/