SELECT
    jpf.job_id,
    jpf.job_title,
    cd.name AS company_name,
    jpf.salary_year_avg,
    CASE
        WHEN salary_year_avg >= 100_000 THEN 'High salary'
        WHEN salary_year_avg >= 60_000 THEN 'Standard salary'
        ELSE 'Low salary'
    END AS salary_category
FROM data_jobs.company_dim AS cd 
LEFT JOIN data_jobs.job_postings_fact AS jpf
    ON jpf.company_id = cd.company_id
WHERE jpf.job_title_short = 'Data Engineer'
    AND jpf.salary_year_avg IS NOT NULL
ORDER BY jpf.salary_year_avg DESC;