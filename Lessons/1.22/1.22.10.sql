CREATE OR REPLACE TABLE job_postings_fact_year_salary AS
SELECT
    job_id,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    job_location
FROM data_jobs.job_postings_fact
WHERE salary_year_avg IS NOT NULL;

SELECT *
FROM job_postings_fact_year_salary;

DELETE FROM job_postings_fact_year_salary 
WHERE job_location IS NULL;

SELECT *
FROM job_postings_fact_year_salary
WHERE job_location IS NOT NULL;