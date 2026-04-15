USE company_jobs;
SELECT current_database();

CREATE OR REPLACE TABLE company_jobs.uk_jobs_archive AS
SELECT *
FROM data_jobs.job_postings_fact
WHERE job_country = 'United Kingdom';

SELECT *
FROM company_jobs.uk_jobs_archive;



