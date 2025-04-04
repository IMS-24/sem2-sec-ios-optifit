-- Step 1: Update start_at_utc with a unique random past timestamp.
-- We use a CTE to assign a random row number to each workout.
WITH cte AS (
    SELECT
        id,
        row_number() OVER (ORDER BY random()) AS rn,
        count(*) OVER () AS total_count
    FROM workout
)
UPDATE workout
SET start_at_utc = current_timestamp
    - (((rn - 1)::numeric / NULLIF(total_count - 1, 0)) * (total_count::numeric * interval '1 day'))
FROM cte
WHERE workout.id = cte.id;

-- Step 2: Update end_at_utc based on start_at_utc plus a random interval.
-- The random interval is generated as a random number of seconds between 2700 (45 minutes) and 10800 (180 minutes).
UPDATE workout
SET end_at_utc = start_at_utc + ((floor(random() * (10800 - 2700 + 1)) + 2700) * interval '1 second');
