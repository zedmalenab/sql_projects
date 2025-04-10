
/*

Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst
- Focus on the roles specified salaries regardless of location
- Why? It reveals different skills impact salary levels for Data Analyst and 
  help identify the most financially rewarding skill
*/

-- Answer Query--

SELECT 
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary

FROM job_postings_fact
INNER JOIN skills_job_dim AS skill_to_job
    ON job_postings_fact.job_id = skill_to_job.job_id
INNER JOIN skills_dim
    ON skill_to_job.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = true

GROUP BY
    skills
ORDER BY
    avg_salary DESC

LIMIT 25


/*

Absolutely—here’s a concise summary of the key insights:

- Big Data & ML Tools Pay Big: Skills like PySpark, Databricks, and DataRobot show that data analysts who can work with large-scale data 
and machine learning pipelines earn significantly more.

- Cloud & DevOps Integration is Essential: Knowledge of cloud platforms (GCP, Kubernetes) and CI/CD tools (GitLab, Jenkins) boosts salaries, 
as analysts increasingly work in production environments.

- Beyond Basics: Programming & Engineering Skills Win: Mastery of Python libraries (Pandas, NumPy), advanced databases (PostgreSQL, Elasticsearch), 
and cross-functional tools positions analysts for top-tier roles.

*/