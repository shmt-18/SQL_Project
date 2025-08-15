/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high—paying skill)?
— Identify skills in high demand and associated with high average salaries for interested roles
— Concentrates on remote positions with specified salaries
— Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in interested fields
*/

SELECT
    skills.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary,
    COUNT(job_postings_fact.job_id) AS job_count
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_to_job
    ON job_postings_fact.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills
    ON skills_to_job.skill_id = skills.skill_id
WHERE
    job_location = 'Anywhere'
    AND
    salary_year_avg IS NOT NULL
    AND
    (
        LOWER(job_postings_fact.job_title) LIKE '%data%'
        OR LOWER(job_postings_fact.job_title) LIKE '%engineer%'
    )
GROUP BY
    skills.skills
HAVING
    COUNT(job_postings_fact.job_id) > 100
ORDER BY
    avg_salary DESC,
    job_count DESC
LIMIT 20;