WITH core_skills AS (
    SELECT
        skill_id,
        type AS skill_type
    FROM data_jobs.skills_dim
    WHERE type IN ('programming', 'databases')
)

SELECT
    cs.skill_type,
    COUNT( DISTINCT sjd.job_id) AS job_count
FROM core_skills AS cs
INNER JOIN data_jobs.skills_job_dim AS sjd
    ON sjd.skill_id = cs.skill_id
GROUP BY cs.skill_type
ORDER BY job_count DESC;