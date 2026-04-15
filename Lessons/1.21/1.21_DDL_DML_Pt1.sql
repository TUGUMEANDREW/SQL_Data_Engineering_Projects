CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

-- DROP DATABASE IF EXISTS jobs_mart;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS jobs_mart.staging;

SELECT *
FROM information_schema.schemata;

-- DROP SCHEMA staging;

CREATE TABLE IF NOT EXISTS staging.preferred_roles (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

DROP TABLE IF EXISTS main.preferred_roles;

DROP TABLE IF EXISTS staging.preferred_roles;

SELECT *
FROM staging.preferred_roles;

INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer');

INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES
    (3, 'Software Engineer');

ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

ALTER TABLE staging.preferred_roles
DROP COLUMN preferred_role;

UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id IN (1,2);

SELECT *
FROM staging.preferred_roles;

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

SELECT *
FROM staging.priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;