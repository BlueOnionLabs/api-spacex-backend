/*
var_id: satellite id to query position
var_creation_date: a time T to pick the last know position of a satellite. Must be informed
in the YYYY-MM-DD HH:MM:SS format.

For this use case, we won't filter out satellites without latitude or longitude but it would be as simples as to add
a WHERE clause in the CTE to remove it.
*/

WITH last_known_creation_date AS (
    SELECT
        id,
        MAX(creation_date) AS max_creation_date
    FROM
        public.spacex
    WHERE
        id = 'var_id'
    GROUP BY 
        id
    HAVING(
        MAX(creation_date) < CAST('var_creation_date' AS TIMESTAMP)
    )
)

SELECT
    positions.id,
    positions.latitude,
    positions.longitude,
    positions.creation_date
FROM
    public.spacex AS positions
INNER JOIN last_known_creation_date ON
    positions.id = last_known_creation_date.id
    AND positions.creation_date = last_known_creation_date.max_creation_date
;