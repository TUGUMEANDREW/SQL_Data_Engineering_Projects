SELECT
    job_id,
    salary_year_avg,
    job_location,
    ROUND(AVG(salary_year_avg) OVER (
        PARTITION BY job_location)) AS location_job_salary
FROM
    job_postings_fact
WHERE salary_year_avg IS NOT NULL;