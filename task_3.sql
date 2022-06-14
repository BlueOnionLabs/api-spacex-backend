/*Query to fetch the last known position of per satellite*/
with starlink_positions as
    (select id satellite_id,latitude,longitude,creation_date position_timestamp,
       ROW_NUMBER() over (partition by id order by creation_date desc) as last_know_position_rank
    from starlink_fact  
    )

select satellite_id, latitude, longitude, position_timestamp
from starlink_positions
where last_know_position_rank = 1


/*Adding filters for a given @satellite in period of @time */
with starlink_positions as
    (
    select  id satellite_id,latitude,longitude,creation_date position_timestamp,
            ROW_NUMBER() over (partition by id order by creation_date desc) as last_know_position_rank
    from starlink_fact
    where cast(creation_date as date) between '2021-01-21' and '2021-01-26' /*given period of time*/
            and
          id = '5eed7714096e590006985676' /*given satellite_id*/
    )
select satellite_id, latitude, longitude, position_timestamp
from starlink_positions
where last_know_position_rank = 1