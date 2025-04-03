-- Step 1: Update start_at_utc with a random past timestamp.
-- The random value is computed as a fraction of the total number of days (equal to the row count) to subtract from the current timestamp.
WITH total_count AS (
    SELECT count(*) AS cnt
    FROM workout
)
UPDATE workout
SET start_at_utc = current_timestamp - (random() * (cnt::numeric) * interval '1 day')
    FROM total_count;

-- Step 2: Update end_at_utc based on start_at_utc plus a random interval.
-- The random interval is generated as a random number of seconds between 2700 (45 minutes) and 10800 (180 minutes).
UPDATE workout
SET end_at_utc = start_at_utc + ((floor(random() * (10800 - 2700 + 1)) + 2700) * interval '1 second');
