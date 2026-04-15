SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
) AS valid_salaries
LIMIT 10;

-- CTE
WITH valid_salaries AS (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)

SELECT *
FROM valid_salaries
LIMIT 10;

-- Show each job's salary next to the overall market median:
SELECT
    job_title_short,
    salary_year_avg,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
    ) AS market_median_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;

-- Stage only jobs that are remote before aggregating to determine the remote median salary per job
SELECT
    job_title_short,
    MEDIAN(Salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS market_remote_median_salary
FROM (
    SELECT
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs
GROUP BY job_title_short
LIMIT 10;

-- Keep only the job titles whose median salary is above the overall median

SELECT
    job_title_short,
    MEDIAN(Salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS market_remote_median_salary
FROM (
    SELECT
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs
GROUP BY job_title_short
HAVING MEDIAN(Salary_year_avg) > 
    (
    SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
)
LIMIT 10;

-- Compare how much more (or less) remote roles pay compared to onsite roles for each job_title.
-- Use a CTE to calculate the median salary by title and work arrangement, then compare those medians.
WITH title_median AS (
    SELECT 
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg)::INT AS market_median_salary
    FROM job_postings_fact
    WHERE job_country = 'United States'
    GROUP BY
        job_title_short,
        job_work_from_home
)

SELECT 
    job_title_short,
    SUM(CASE WHEN job_work_from_home = TRUE THEN market_median_salary ELSE 0 END) AS remote_median_salary,
    SUM(CASE WHEN job_work_from_home = FALSE THEN market_median_salary ELSE 0 END) AS onsite_median_salary,
    remote_median_salary - onsite_median_salary AS remote_premium
FROM title_median
GROUP BY job_title_short
ORDER BY remote_premium DESC;

-- Luke's Version
WITH title_median AS (
    SELECT 
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg)::INT AS median_salary
    FROM job_postings_fact
    WHERE job_country = 'United States'
    GROUP BY
        job_title_short,
        job_work_from_home
)

SELECT
    r.job_title_short,
    r.median_salary AS remote_median_salary,
    o.median_salary AS onsite_median_salary,
    r.median_salary - o.median_salary AS remote_premium
FROM title_median AS r
INNER JOIN title_median AS o
    ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE
    AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC;

-- EXISTENCE FILTERING

SELECT *
FROM range(5) AS src(key)
WHERE EXISTS (
    SELECT 1
    FROM range(2) AS tgt(key)
    WHERE tgt.key = src.key
);

-- Identify job postings that have no associated skills before loading them into a data mart.
SELECT
    jpf.job_id
FROM job_postings_fact AS jpf
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd
    WHERE jpf.job_id = sjd.job_id
)
ORDER BY job_id;

SELECT
    sjd.skill_id
FROM skills_job_dim AS sjd
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_dim AS sd
    WHERE sjd.skill_id = sd.skill_id
)
ORDER BY sjd.skill_id;