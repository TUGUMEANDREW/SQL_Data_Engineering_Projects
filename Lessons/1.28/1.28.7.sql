SELECT
    rj.job_title,
    rj.company_id, 
    rj.job_location
FROM work_mode_mart.remote_jobs AS rj
EXCEPT
SELECT
    nrj.job_title,
    nrj.company_id, 
    nrj.job_location
FROM work_mode_mart.not_remote_jobs AS nrj
ORDER BY
    job_location,
    company_id,
    job_title;