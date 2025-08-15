/*
Purpose: What are the most in—demand skills for data focused jobs?
- Identify the top in-demand skills.
- Focus on all job postings.

Why?
Retrieves the top 10 skills with the highest demand in providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills.skills,
    COUNT(*) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_to_job
    ON job_postings_fact.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills
    ON skills_to_job.skill_id = skills.skill_id
WHERE
--    job_location = 'Anywhere'
--    AND 
    (
        LOWER(job_postings_fact.job_title) LIKE '%data%'
        OR LOWER(job_postings_fact.job_title) LIKE '%engineer%'
        )
GROUP BY
    skills.skills
ORDER BY
    demand_count DESC
LIMIT 10;

/*
Query Answer:
"skills","demand_count"
"python","364204"
"sql","357840"
"aws","142009"
"azure","128291"
"r","122550"
"tableau","113417"
"spark","112766"
"excel","102241"
"power bi","85643"
"java","83016"

# Insightful Conclusion
The results of this query reveal a critical distinction between foundational skills and specialized ones. While our previous analysis of top-paying jobs highlighted the importance of a wide range of advanced tools, this broader view across all data-focused job postings underscores a clear message:

The highest demand is for fundamental, versatile skills. Python and SQL are overwhelmingly the two most sought-after skills, with demand counts that are more than double that of any other skill. This reinforces their status as the cornerstone of the modern data and engineering landscape. Following these, cloud computing skills (AWS and Azure) and popular data visualization tools (Tableau and Power BI) also show very high demand, indicating that companies are increasingly seeking professionals who can work with data across various platforms and effectively communicate their findings. This data suggests that mastering the basics is the most reliable path to entry and growth in the data job market.
*/