-- ARRAY
SELECT
    ['python', 'sql', 'r'] AS skills_array;

WITH skills AS (
SELECT 'python' AS skill
UNION ALL
SELECT 'sql'
UNION ALL
SELECT 'r')

SELECT
    LIST(skill)
FROM
    skills;

WITH skills AS (
SELECT 'python' AS skill
UNION ALL
SELECT 'sql'
UNION ALL
SELECT 'r'
), skills_array AS (
SELECT ARRAY_AGG(skill ORDER BY skill) AS skills
FROM skills
)

SELECT
    skills[1] AS first_skill,
    skills[2] AS second_skill,
    skills[3] AS third_skill
FROM skills_array;

-- STRUCT
SELECT {skill:'python', skill_type: 'programming'} AS skill_struct;

SELECT
    STRUCT_PACK(
        skill := 'python',
        skill_type := 'programming'
    ) AS struct;

WITH structs AS (
SELECT
    STRUCT_PACK(
        skill := 'python',
        skill_type := 'programming'
    ) AS struct
)

SELECT
    struct.skill AS skill,
    struct.skill_type AS skill_type
FROM structs;

WITH skill_table AS (
SELECT 'python' AS skills, 'programming' AS types
UNION ALL
SELECT 'sql', 'query_language'
UNION ALL
SELECT 'r', 'programming'
) 
SELECT
    skills,
    types,
    STRUCT_PACK(
        skill := skills,
        type := types
    ) AS skill_struct
FROM skill_table;

-- ARRAY OF STRUCTS
SELECT [
    {skill: 'python', type: 'programming'},
    {skill: 'sql', type: 'query_language'}
] AS skills_array_of_structs;


WITH skill_table AS (
SELECT 'python' AS skills, 'programming' AS types
UNION ALL
SELECT 'sql', 'query_language'
UNION ALL
SELECT 'r', 'programming'
) 
SELECT
    LIST(
        STRUCT_PACK(
            skill := skills,
            type := types
        )
    ) AS skill_array_of_structs
FROM skill_table;


WITH skill_table AS (
SELECT 'python' AS skills, 'programming' AS types
UNION ALL
SELECT 'sql', 'query_language'
UNION ALL
SELECT 'r', 'programming'
), skill_array_of_structs AS (
SELECT
    LIST(
        STRUCT_PACK(
            skill := skills,
            type := types
        )
    ) AS skill_array_of_structs
FROM skill_table
)
SELECT
    skill_array_of_structs[2].skill AS second_skill,
    skill_array_of_structs[2].type AS second_type,
FROM skill_array_of_structs;

-- MAP
SELECT MAP {'skill':'python', 'type': 'programming'};

WITH skill_map AS (
SELECT MAP {'skill':'python', 'type': 'programming'} AS skill_type
)
SELECT
    skill_type['skill']
FROM skill_map;

-- JSON
SELECT
    '{"skill":"python", "type":"programming"}'::JSON AS skill_json;

WITH raw_skill_json AS (
SELECT
    '{"skill":"python", "type":"programming"}'::JSON AS skill_json
)
SELECT
    STRUCT_PACK(
        skill := json_extract_string(skill_json, '$.skill'),
        type := json_extract_string(skill_json, '$.type')
    )
FROM raw_skill_json;

-- JSON to Array of Structs
WITH raw_json AS (
    SELECT
        '[
        {"skill":"python", "type":"programming"},
        {"skill":"sql", "type":"query_language"},
        {"skill":"r", "type":"programming"}
        ]'::JSON AS skills_json
)

SELECT
    ARRAY_AGG(
        STRUCT_PACK(
            skill := json_extract_string(e.value, '$.skill'),
            type := json_extract_string(e.value, '$.type')    
        )
        ORDER BY json_extract_string(e.value, '$.skill')
    ) AS skills
FROM raw_json, json_each(skills_json) AS e;

-- Final Example 1
-- Build a flat skill table for co-workers to access job titles, salary info and skills in one table
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(sd.skills) AS skills_array
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
GROUP BY
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg
ORDER BY 
      jpf.job_id;

-- From the perspective of a Data Analyst, analyse the median salary per skill
CREATE OR REPLACE TEMP TABLE job_skills_array AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(sd.skills) AS skills_array
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
GROUP BY
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg
ORDER BY 
      jpf.job_id;

WITH flat_skills AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        UNNEST(skills_array) AS skills
    FROM job_skills_array
)
SELECT
    skills,
    MEDIAN(salary_year_avg) AS median_salary
FROM flat_skills
GROUP BY
    skills
ORDER BY
    median_salary DESC;

-- Final Example 2
-- Build a flat skill and type table for co-workers to access job titles, salary info, skills and type in one table

CREATE OR REPLACE TEMP TABLE job_skills_array_struct AS
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(    
        STRUCT_PACK(
            skill_type := sd.type,
            skill_name := sd.skills
        )
    ) AS skills_type   
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
GROUP BY
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg;

-- From the perspective of a Data Analyst, analyse the median salary per type of skill

WITH unnested_skills AS (
SELECT 
    job_id,
    job_title_short,
    salary_year_avg,
    UNNEST(skills_type).skill_type AS skill_type,
    UNNEST(skills_type).skill_name AS skill_name,
FROM job_skills_array_struct
)

SELECT
    skill_type,
    MEDIAN(salary_year_avg) AS median_salary
FROM unnested_skills
GROUP BY 
    skill_type
ORDER BY median_salary DESC;