-- Creating the different tables needed for analysis in the database
CREATE TABLE milk_production (
 Year INTEGER,
 Period TEXT,
 Geo_Level TEXT,
 State_ANSI INTEGER,
 Commodity_ID INTEGER,
 Domain TEXT,
 Value INTEGER );

 CREATE TABLE cheese_production (
 Year INTEGER,
 Period TEXT,
 Geo_Level TEXT,
 State_ANSI INTEGER,
 Commodity_ID INTEGER,
 Domain TEXT,
 Value INTEGER );

 CREATE TABLE coffee_production (
 Year INTEGER,
 Period TEXT,
 Geo_Level TEXT,
 State_ANSI INTEGER,
 Commodity_ID INTEGER,
 Value INTEGER );

 CREATE TABLE egg_production (
 Year INTEGER,
 Period TEXT,
 Geo_Level TEXT,
 State_ANSI INTEGER,
 Commodity_ID INTEGER,
 Value INTEGER );

 CREATE TABLE honey_production (
 Year INTEGER,
 Geo_Level TEXT,
 State_ANSI INTEGER,
 Commodity_ID INTEGER,
 Value INTEGER );

 CREATE TABLE state_lookup (
 State TEXT,
 State_ANSI INTEGER );

CREATE TABLE yogurt_production (
 Year INTEGER,
 Period TEXT,
 Geo_Level TEXT,
 State_ANSI INTEGER,
 Commodity_ID INTEGER,
 Domain TEXT,
 Value INTEGER );

-- STEP 2: Import the different tables that are in CSV format
/* Data Cleaning 
The CSV files were cleaned by changing the 'value' column to text for import*/
ALTER TABLE cheese_production
ALTER COLUMN value TYPE TEXT;
UPDATE cheese_production
SET value = REPLACE(value, ',', '');
SELECT CAST(value AS BIGINT) 
FROM cheese_production;
SELECT * 
FROM cheese_production;

/* Importing coffee table and conversion*/
ALTER TABLE coffee_production
ALTER COLUMN value TYPE TEXT;
UPDATE coffee_production 
SET value = REPLACE(value, ',', '');

/* Importing egg table and conversion*/
ALTER TABLE egg_production
ALTER COLUMN value TYPE TEXT;
UPDATE egg_production 
SET value = REPLACE(value, ',', '');

/* Importing honey table and conversion*/
ALTER TABLE honey_production
ALTER COLUMN value TYPE TEXT;
UPDATE honey_production 
SET value = REPLACE(value, ',', '');

/* Importing milk table and conversion*/
ALTER TABLE milk_production
ALTER COLUMN value TYPE TEXT;
UPDATE milk_production 
SET value = REPLACE(value, ',', '');

/* Importing yogurt_production table and conversion*/
ALTER TABLE yogurt_production
ALTER COLUMN value TYPE TEXT;
UPDATE yogurt_production 
SET value = REPLACE(value, ',', '');

-- converting the 'value' column datatype back to Integer
UPDATE cheese_production
SET value = REGEXP_REPLACE(value, '[^0-9]', '', 'g');
ALTER TABLE cheese_production
ALTER COLUMN value TYPE BIGINT
USING NULLIF(value, '')::BIGINT;

UPDATE coffee_production
SET value = REGEXP_REPLACE(value, '[^0-9]', '', 'g');
ALTER TABLE coffee_production
ALTER COLUMN value TYPE BIGINT
USING NULLIF(value, '')::BIGINT;

UPDATE egg_production
SET value = REGEXP_REPLACE(value, '[^0-9]', '', 'g');
ALTER TABLE egg_production
ALTER COLUMN value TYPE BIGINT
USING NULLIF(value, '')::BIGINT;

UPDATE honey_production
SET value = REGEXP_REPLACE(value, '[^0-9]', '', 'g');
ALTER TABLE honey_production
ALTER COLUMN value TYPE BIGINT
USING NULLIF(value, '')::BIGINT;

UPDATE milk_production
SET value = REGEXP_REPLACE(value, '[^0-9]', '', 'g');
ALTER TABLE milk_production
ALTER COLUMN value TYPE BIGINT
USING NULLIF(value, '')::BIGINT;

UPDATE yogurt_production
SET value = REGEXP_REPLACE(value, '[^0-9]', '', 'g');
ALTER TABLE yogurt_production
ALTER COLUMN value TYPE BIGINT
USING NULLIF(value, '')::BIGINT;


-- SOLVING THE PROBLEM
-- The following questions were answered to uncover patterns in the data
--1. Find the total milk production for the year 2023
SELECT 
	SUM(value) AS TotalProduction2023
FROM milk_production
WHERE year = 2023;

-- 2. Show coffee production
SELECT * 
FROM coffee_production
WHERE year = 2015;

-- 3. Find the average honey production for the year 2022
SELECT AVG(value) AS AVG_production
FROM honey_production
WHERE year = 2022;

-- 4. Get the state names with their corresponding ANSI codes from the state_lookup table.
-- What is IOWA?
SELECT 
	state, state_ansi
FROM state_lookup
WHERE state = 'IOWA';

-- 5. Find the highest yogurt production value for the year 2022
SELECT 
	MAX(value) AS Max_production_value
FROM yogurt_production
WHERE year = 2022;

-- 6. Find states where both honey and milk were produced in 2022.
-- Did State_ANSI '35' produce both honey and milk in 2022?
SELECT 
	DISTINCT m.state_ansi
FROM milk_production m
INNER JOIN honey_production h
	ON m.state_ansi = h.state_ansi
WHERE m.year = 2022 
	AND h.year = 2022;

-- 7. Find the total yogurt production for states that also produced cheese in 2022.
SELECT 
	SUM(value) AS Tot_yogurt_prod
FROM yogurt_production
WHERE year = 2022
	AND state_ansi IN(
		SELECT state_ansi
		FROM  cheese_production
		WHERE year = 2022
	);
	
SELECT * FROM state_lookup;
SELECT * FROM cheese_production;

-- FINAL PROJECT
-- 1. What is the total milk production for 2023?
SELECT 
	SUM(value) AS tot_milk_production
FROM milk_production
WHERE year = 2023;

-- 2. Which states had cheese production greater than 100 million in April 2023?
-- The cheese department wants to focus their marketing efforts there.
-- How many states are there?
-- Query to get the states:
SELECT 
	cp.state_ansi
FROM cheese_production cp
JOIN state_lookup sl
	ON cp.state_ansi = sl.state_ansi
WHERE cp.year = 2023
	AND cp.period = 'APR'
GROUP BY sl.state, cp.state_ansi
HAVING SUM(cp.value) > 100000000;
--Query to count how many states:
SELECT
	COUNT(*) AS num_states
FROM(
	SELECT 
		cp.state_ansi
	FROM cheese_production cp
	JOIN state_lookup sl
		ON cp.state_ansi = sl.state_ansi
	WHERE cp.year = 2023
		AND cp.period = 'APR'
	GROUP BY sl.state, cp.state_ansi
	HAVING SUM(cp.value) > 100000000	
) AS filtered_states;

-- 3. Your manager wants to know how coffee production has changed over the years. 
-- What is the total value of coffee production for 2011?
SELECT 
	SUM(value) AS total_coffee_production
FROM coffee_production
WHERE year = 2011;

-- 4. There's a meeting with the Honey Council next week. 
-- Find the average honey production for 2022 so you're prepared.
SELECT 
	AVG(value) AS avg_honey_production
FROM honey_production
WHERE year = 2022;

-- 5. The State Relations team wants a list of all states names with their corresponding ANSI codes. Can you generate that list?
-- What is the State_ANSI code for Florida?
SELECT 
	state, state_ansi 
FROM state_lookup
WHERE state = 'FLORIDA';

-- 6. For a cross-commodity report, can you list all states with their cheese production values, even if they didn't produce any cheese in April of 2023?
--What is the total for NEW JERSEY?
SELECT 
	sl.state,
	COALESCE(SUM(cp.value),0) AS total_cheese_production
FROM state_lookup sl
LEFT JOIN cheese_production cp
	ON sl.state_ansi = cp.state_ansi
	AND cp.year = 2023
	AND cp.period = 'APR'
GROUP BY sl.state
ORDER BY sl.state;
-- Specifically for New Jersey:
SELECT
	sl.state, 
	COALESCE(SUM(value),0) AS total_cheese
FROM state_lookup sl
LEFT JOIN cheese_production cp
	ON sl.state_ansi = cp.state_ansi
	AND cp.year = 2023
	AND cp.year = 2023
WHERE sl.state = 'NEW JERSEY'
GROUP BY sl.state;

/* 7. Can you find the total yogurt production for states in the year 2022 which also have cheese production data from 2023? 
This will help the Dairy Division in their planning. */
-- Using a subquery
SELECT 
	yp.state_ansi,
	SUM(yp.value) AS total_yogurt
FROM yogurt_production yp
WHERE yp.year = 2022
	AND yp.year = 2023
	AND yp.state_ansi IN (
		SELECT 
			DISTINCT cp.state_ansi
		FROM cheese_production cp
		WHERE cp.year = 2023
			AND cp.year < 2024	
	)
GROUP BY yp.state_ansi;	

--8. List all states from state_lookup that are missing from milk_production in 2023.
--How many states are there?
SELECT 
	sl.state
FROM state_lookup sl
LEFT JOIN milk_production mp
  ON sl.state_ansi = mp.state_ansi
  AND mp.year = 2023
WHERE mp.state_ansi IS NULL;
-- Count how many states
SELECT COUNT(*) AS num_states
FROM state_lookup sl
LEFT JOIN milk_production mp
  ON sl.state_ansi = mp.state_ansi
  AND mp.year = 2023
WHERE mp.state_ansi IS NULL;

--9.  List all states with their cheese production values, including states that didn't produce any cheese in April 2023.
-- Did Delaware produce any cheese in April 2023?

SELECT 
    sl.state,
    COALESCE(SUM(cp.value), 0) AS total_cheese_production
FROM state_lookup sl
LEFT JOIN cheese_production cp
  ON sl.state_ansi = cp.state_ansi
  AND cp.year = 2023
  AND cp.period = 'APR'
GROUP BY sl.state
ORDER BY sl.state;

--Check specifically for Delaware:
SELECT 
    sl.state,
    COALESCE(SUM(cp.value), 0) AS total_cheese_production
FROM state_lookup sl
LEFT JOIN cheese_production cp
  ON sl.state_ansi = cp.state_ansi
  AND cp.year = 2023
  AND cp.period = 'APR'
WHERE sl.state = 'Delaware'
GROUP BY sl.state;

-- 10. Find the average coffee production for all years where the honey production exceeded 1 million.
SELECT 
	AVG(cp.value) AS avg_coffee_production
FROM coffee_production cp
WHERE cp.year IN (
    SELECT hp.year
    FROM honey_production hp
    GROUP BY hp.year
    HAVING SUM(hp.value) > 1000000
);

SELECT * FROM cheese_production;