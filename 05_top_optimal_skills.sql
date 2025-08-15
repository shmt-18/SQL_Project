/*
Purpose: What are the most optimal skills to learn (aka it's in high demand and a high—paying skill)?
— Identify skills in high demand and associated with high average salaries for interested roles
— Concentrates on remote positions with specified salaries

Why?
Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in interested fields
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
HAVING
    COUNT(job_postings_fact.job_id) > 100
ORDER BY
    avg_salary DESC,
    job_count DESC
LIMIT 20;

/*
# Results:
"skills","avg_salary","job_count"
"mongo","171239","260"
"cassandra","154773","525"
"neo4j","149623","120"
"pytorch","145404","1020"
"scala","145347","1896"
"kafka","144888","1634"
"golang","144121","107"
"shell","143991","722"
"tensorflow","143004","1160"
"airflow","142478","1485"
"spark","142068","3962"
"redshift","141437","1498"
"scikit-learn","140098","662"
"dynamodb","139779","219"
"redis","139634","117"
"hadoop","138635","2240"
"snowflake","138537","2405"
"kubernetes","138301","906"
"pandas","137629","1027"
"nosql","137410","1661"
---
Based on the results, the most optimal skills to learn are those that exist at the intersection of big data, machine learning, and cloud-native infrastructure. These skills provide a strategic advantage by balancing high demand with exceptional earning potential.

# Key Insights:
Big Data is a High-Value Field: The list is dominated by big data frameworks. Spark, Kafka, and Hadoop are foundational for processing vast datasets. Their high job count and salaries indicate a strong and secure career path in data engineering.

The Power of Cloud-Native Infrastructure: Tools like Snowflake, Redshift (cloud data warehouses), and Kubernetes (container orchestration) are essential for building scalable, cloud-based data platforms. Learning these skills ensures you are prepared for the modern data stack.

Machine Learning is Not Just a Niche: Skills like PyTorch, Tensorflow, and Scikit-learn show that the ability to build, train, and deploy machine learning models is not only in demand but also commands a high salary. This confirms that ML engineering is a highly lucrative career path.

Specialized Database Expertise Pays Well: While SQL is foundational, skills in non-relational databases like Mongo, Cassandra, and Neo4j are highly valued, particularly for handling specific, complex data models.

Connecting the Pieces: The presence of Airflow (for workflow orchestration) and Kafka (for data streaming) highlights the value of skills that integrate different parts of a data pipeline. A professional who can orchestrate and manage a seamless flow of data is a critical asset.
*/