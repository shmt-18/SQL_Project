/*
Question: What are the top-paying jobs focusing on data?
— Identify the top 10 highest—paying roles that are available remotely.
— Focuses on job postings with specified salaries (remove nulls).
— Why? Highlight the top—paying opportunities, offering insights into the demand for data-focused roles.
*/

SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title_short,
    job_postings_fact.job_title,
    company_dim.name AS company_name,
    ROUND(job_postings_fact.salary_year_avg, 0) AS salary_year_avg,
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
LIMIT 10;
