EXPLAIN ANALYZE
SELECT
    job_posted_date::DATE AS dt,
    COUNT(job_id) AS job_postings
FROM
    job_postings_fact
GROUP BY
    job_posted_date::DATE
HAVING
    job_posted_date::DATE = '2024-12-31';


SELECT
    COUNT(job_id)
FROM
    job_postings_fact
WHERE
    job_posted_date::DATE = '2024-12-31';

EXPLAIN ANALYZE
SELECT 
  jpf.job_posted_date::DATE AS dt,
  COUNT(job_id) AS job_postings
FROM job_postings_fact AS jpf
WHERE 
  jpf.job_posted_date::DATE = '2024-12-31'
GROUP BY 
  dt;