USE SCHEMA work_mode_mart;

CREATE OR REPLACE TABLE work_mode_mart.not_remote_jobs AS
SELECT
    j.job_title,
    j.company_id, 
    j.job_location
FROM data_jobs.job_postings_fact AS j
WHERE j.job_work_from_home <> TRUE
    OR j.job_work_from_home IS NULL;

SELECT COUNT(*)
FROM work_mode_mart.not_remote_jobs;
