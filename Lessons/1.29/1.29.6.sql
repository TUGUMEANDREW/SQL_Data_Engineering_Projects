SELECT
    job_id,
    COALESCE(TRIM(job_location),'Remote') AS location_clean
FROM job_postings_fact
WHERE
    TRIM(job_location) IS NULL;