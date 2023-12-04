-- LAST POSITIONS
WITH LAST_POSITIONS AS (
    SELECT id, MAX(spacetrack.creation_date) AS max_date FROM starlink_test GROUP BY id
)
SELECT starlink_test.id, longitude, latitude, spacetrack.creation_date FROM starlink_test
INNER JOIN LAST_POSITIONS ON (LAST_POSITIONS.id = starlink_test.id AND LAST_POSITIONS.max_date = starlink_test.spacetrack.creation_date)
WHERE IS_NAN(latitude) = False AND IS_NAN(longitude) = False
LIMIT 10