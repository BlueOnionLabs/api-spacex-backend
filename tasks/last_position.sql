/*
For this use case, it doesn't makes sense to pull rows without latitude or longitude, so I'll filter them out.
*/

WITH last_known_creation_date AS (
    SELECT
        id,
        MAX(creation_date) AS max_creation_date
    FROM
        public.spacex
    WHERE
        latitude IS NOT NULL
        AND longitude IS NOT NULL
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