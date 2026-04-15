SELECT
    job_id,
    COUNT(*) OVER ()
FROM job_postings_fact;

-- PARTION BY 
SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY job_title_short
    ) AS adjusted
FROM job_postings_fact;