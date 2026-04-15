WITH location_data AS (
    SELECT
        job_id,
        LOWER(TRIM(job_location)) AS cleaned_location
    FROM job_postings_fact
)

SELECT
    job_id,
    cleaned_location,
    CASE
        WHEN cleaned_location LIKE '%remote%' OR cleaned_location LIKE '%anywhere%' THEN 'Remote'
        WHEN NULLIF(cleaned_location, '') IS NULL THEN 'Global'
        ELSE 'On-site/Hybrid'
    END AS location_category
FROM location_data;