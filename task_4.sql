/*1. Create procedure for calculating distance for a given date, based on latitude and longitude using spatial built-in mysql function*/
CREATE procedure sp_closest_satellite_per_day ( IN _position_date datetime, IN _longitude double, IN _latitude double, OUT _satellite_id text)
    BEGIN
        with starlink_positions as
            (
            select id satellite_id,latitude,longitude,cast(creation_date as date) position_date,
                ROW_NUMBER() over (partition by id, cast(creation_date as date) order by creation_date desc) as last_know_position_by_day,
                ST_Distance_Sphere(point(longitude,latitude), point(_longitude,_latitude) ) distance_in_meters
            from starlink_fact
            where latitude is not null and longitude is not null /*filtering just specific locations*/
            )

        select satellite_id
        into _satellite_id
        from starlink_positions
        where last_know_position_by_day = 1 /*last position by day*/
             and position_date = _position_date
        order by distance_in_meters
        limit 1; /*closest location*/
    end;

/*2. Call proc and send parameters*/
call sp_closest_satellite_per_day('2021-01-26',56,50,@satellite_id)
select @satellite_id