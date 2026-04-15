WITH priority_list AS (
    SELECT
        UNNEST(['Data Engineer', 'Data Scientist','Senior Data Engineer']) AS special_jobs
)
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg
FROM job_postings_fact AS jpf
INNER JOIN priority_list AS pl ON jpf.job_title_short = pl.special_jobs;