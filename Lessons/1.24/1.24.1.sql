CREATE SCHEMA IF NOT EXISTS staging;

CREATE OR REPLACE TABLE staging.priority_skills (
    skill_id INTEGER PRIMARY KEY,
    skill_name VARCHAR(50),
    priority_lvl INTEGER
);

INSERT INTO staging.priority_skills (skill_id, skill_name, priority_lvl)
VALUES
    (1, 'python', 1),
    (0, 'sql', 1),
    (183, 'tableau', 2);

SELECT *
FROM staging.priority_skills;

SELECT *
FROM information_schema.schemata;

