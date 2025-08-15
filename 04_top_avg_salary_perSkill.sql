/*
Purpose: What are the top skills based on salary?
- Look at the average salary associated with each skill for data related positions
- Focuses on roles with specified salaries, regardless of location

Why?
It reveals how different skills impact salary levels for data related roles and helps identify the most financially rewarding skills to acquire or improve
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

/*

# Results:
"skills","avg_salary"
"debian","196500"
"ringcentral","182500"
"mongo","171239"
"lua","170500"
"solidity","164563"
"dplyr","160667"
"node","156201"
"asp.net core","155000"
"hugging face","154929"
"cassandra","154773"
"watson","154106"
"codecommit","152289"
"rshiny","151611"
"neo4j","149623"
"gatsby","147500"
"theano","146598"
"pytorch","145404"
"scala","145347"
"mxnet","145334"
"mlr","145000"

The list of skills isn't what one might expect from a "most in-demand" list. Instead of foundational skills like Python and SQL, it highlights a set of highly specialized and often niche technologies.

# Key Insights from the Results:
Specialization Commands a Premium: The highest-paying skills are not the most common ones. They are highly specialized and often tied to specific, high-value problem domains. This contrasts sharply with the "most in-demand" list, where foundational skills like Python and SQL dominate.

AI and Machine Learning Expertise Pays Off: Skills like Pytorch, Hugging Face, and Theano are all associated with deep learning and advanced machine learning. The presence of these skills at the top of the list indicates that data professionals who can work at the forefront of AI and model development are among the highest earners.

The Rise of Specialized Databases: Skills such as Mongo (a document-based NoSQL database), Cassandra (a distributed NoSQL database), and Neo4j (a graph database) are highly compensated. This suggests that expertise in managing complex, non-traditional data structures—beyond what a traditional relational database can handle—is a significant salary driver.

Full-Stack and Niche Engineering is Valuable: The list includes skills like Node, ASP.NET Core, and Scala, which are typically associated with software development and backend engineering. This implies that a data professional who can also build and manage applications or services is a more valuable asset to a company. For example, Scala is highly valued for its use in big data frameworks like Apache Spark.

The Principle of Supply and Demand: The results are a perfect illustration of the economic concept of supply and demand. The skills on this list are likely less common, meaning there is a lower supply of qualified professionals. When this low supply meets a high demand for a specialized role (e.g., a data scientist who is also an expert in blockchain with Solidity), the salary for that skill is driven up significantly.

In conclusion, while mastering foundational skills like SQL and Python is crucial for securing a job, acquiring a specialized, high-value skill is the key to unlocking the highest salary tiers. The data suggests that financial success lies in gradually moving from a generalist to a specialist in a niche area of technology.
*/