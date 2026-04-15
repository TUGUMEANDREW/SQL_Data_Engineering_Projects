SELECT
    job_id,
    TRIM(job_title),
    TRIM(job_location)
FROM job_postings_fact
WHERE
    NULLIF(TRIM(job_title), TRIM(job_location)) IS NULL;