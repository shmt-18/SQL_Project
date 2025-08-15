/*
Question: What are the most in—demand skills for data focused jobs?
- Identify the top in-demand skills.
- Focus on all job postings.
- Why? Retrieves the top 10 skills with the highest demand in providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills.skills,
    job_location,
    COUNT(*) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_to_job
    ON job_postings_fact.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills
    ON skills_to_job.skill_id = skills.skill_id
WHERE
    job_location = 'Anywhere'
    AND (
        LOWER(job_postings_fact.job_title) LIKE '%data%'
        OR LOWER(job_postings_fact.job_title) LIKE '%engineer%'
        )
GROUP BY
    skills.skills,
    job_location
ORDER BY
    demand_count DESC
LIMIT 10;