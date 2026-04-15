/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT
    sd.skills,
    COUNT(jpf.job_id) AS demand_count
FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
GROUP BY
    sd.skills
ORDER BY
    COUNT(jpf.job_id) DESC
LIMIT 10;

/*
The most demanded skills for data engineers are sql and python with roughly
29,000 job postings each.
Additionally cloud platoforms like aws and azure are also high in demand
with ~18,000 and ~14,000 respectively. 
Data pipeline tools for big data are also highly on demand with Airtable, Snowflake,
Databricks fetching a moderate demand count of ~10,000 ~8,600 and ~8100 respectively.

Key insights:
- SQL and Python are the fundamental skill tools for data engineers.
- Cloud platforms like AWS and Azure are highly markettable for data engineers
- A data engineer needs data pipeline tools like Airflow, Snowflake, Databricks


┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
├────────────┴──────────────┤
│ 10 rows         2 columns │
└───────────────────────────┘

*/