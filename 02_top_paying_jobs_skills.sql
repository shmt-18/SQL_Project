/*
Purpose:
What skills are required for the top—paying data focused jobs?
- Add the specific skills required for these roles

Why?
It provides a detailed look at which high—paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_postings_fact.job_id,
        job_postings_fact.job_title_short,
        job_postings_fact.job_title,
        company_dim.name AS company_name,
        job_postings_fact.salary_year_avg,
        job_postings_fact.job_work_from_home

    FROM job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_postings_fact.salary_year_avg IS NOT NULL
        AND
        job_postings_fact.job_work_from_home = 'Yes'
        AND
        (LOWER(job_postings_fact.job_title_short) LIKE '%data%'
        OR LOWER(job_postings_fact.job_title_short) LIKE '%analy%'
        OR LOWER(job_postings_fact.job_title_short) LIKE '%engineer%')
    ORDER BY
        job_postings_fact.salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim AS skills_to_job
    ON top_paying_jobs.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills
    ON skills_to_job.skill_id = skills.skill_id