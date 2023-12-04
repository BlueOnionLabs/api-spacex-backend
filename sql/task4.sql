-- GET CLOSEST POSITION FROM GIVING lat / long and filtered by creation_date
SELECT  id, 
        great_circle_distance(latitude, longitude,  33.94, -118.40) AS DistanceKM, 
        spacetrack.creation_date 
FROM starlink_test
WHERE IS_NAN(latitude) = False AND IS_NAN(longitude) = False AND spacetrack.creation_date = '2021-01-26T06:36:09' ORDER BY DistanceKM ASC LIMIT 10