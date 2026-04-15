SELECT
    job_id,
    COALESCE(job_schedule_type, 'Not Specified') AS schedule_info
FROM job_postings_fact;