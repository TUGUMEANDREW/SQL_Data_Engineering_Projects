SELECT
    job_id,
    TRIM(job_location) AS job_location_clean
FROM job_postings_fact;