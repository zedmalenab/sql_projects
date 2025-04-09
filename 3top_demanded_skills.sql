
SELECT 
    skills,
    COUNT(skill_to_job.job_id) AS demand_count

FROM job_postings_fact
INNER JOIN skills_job_dim AS skill_to_job
    ON job_postings_fact.job_id = skill_to_job.job_id
INNER JOIN skills_dim
    ON skill_to_job.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst'

GROUP BY
    skills

ORDER BY
    demand_count DESC

LIMIT 5

/*

*/