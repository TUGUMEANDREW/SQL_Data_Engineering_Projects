MERGE INTO 
    main.job_skill_priorities AS tgt
USING
    staging.priority_skills AS src
ON
    tgt.skill_id = src.skill_id

WHEN MATCHED THEN
    UPDATE SET
        skill_name = src.skill_name;

SELECT *
FROM main.job_skill_priorities;