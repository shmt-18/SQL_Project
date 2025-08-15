/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for data related positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for data related roles and helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_to_job
    ON job_postings_fact.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills
    ON skills_to_job.skill_id = skills.skill_id
WHERE
--    job_location = 'Anywhere'
--    AND 
    salary_year_avg IS NOT NULL
    AND
    (
        LOWER(job_postings_fact.job_title) LIKE '%data%'
        OR LOWER(job_postings_fact.job_title) LIKE '%engineer%'
        )
GROUP BY
    skills.skills
ORDER BY
    avg_salary DESC
LIMIT 20;