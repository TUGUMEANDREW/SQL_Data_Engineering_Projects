WITH skills_count_cte AS (
    SELECT
        jpf.company_id,
        ARRAY_LENGTH(ARRAY_AGG(DISTINCT sjd.skill_id)) AS skill_count
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    GROUP BY jpf.company_id
),
company_skills AS (
    SELECT 
        cd.name AS company_name,
        scc.skill_count,
        DENSE_RANK() OVER (
            ORDER BY skill_count DESC
        ) AS company_skill_rank
    FROM skills_count_cte AS scc
    INNER JOIN company_dim AS cd ON cd.company_id = scc.company_id
)

SELECT *
FROM company_skills
WHERE company_skill_rank <= 10;