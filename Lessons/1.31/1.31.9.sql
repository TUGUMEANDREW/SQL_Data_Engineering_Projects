WITH unique_skills AS (
    SELECT
        sjd.job_id,
        jpf.company_id,
        COUNT(DISTINCT skill_id) AS unique_skill_count
    FROM job_postings_fact AS jpf
    iNNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    GROUP BY
        sjd.job_id,
        jpf.company_id
),
average_job_skills_count AS (
    SELECT
        company_id,
        AVG(unique_skill_count) AS average_skills_required
    FROM unique_skills
    GROUP BY
        company_id
)

SELECT
    us.job_id,
    us.unique_skill_count,
    ajsc.average_skills_required
FROM average_job_skills_count AS ajsc
INNER JOIN unique_skills AS us ON ajsc.company_id = us.company_id
WHERE us.unique_skill_count > average_skills_required
ORDER BY us.unique_skill_count DESC
LIMIT 100;