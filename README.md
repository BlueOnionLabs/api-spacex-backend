# Luiz Menniti - Case Study

# Question 1
I`ve setup a docker-compose that has 1 image, that starts 2 container
The credentials is setup already into docker-compose

Container 1 - That provides a API that allow to send a query into API as a parameter query 

The system do a query directly from Amazon Athena Serverless Warehouse, using a single API rest

With postman -> `http://localhost:5000/athena_api?query=select * from starlink_test limit 10` 

Container 2 - Start ETL read the json file and upload it into S3 bucket

Benefits
- No need to manage. 
- The solution provides big scale, something that postgres/mysql are not designed to handle
- Glue Metastore, is the Hive metastore managed services from Amazon (Free) 
- Data saved directly on S3 bucket, so the costs of amount of data stored are very cheap comparing with SSD.
- The ETLs, can be started directly from a image docker, allowing us to grow the ETLs and schedule it with K8s

# Question 2-4

The answers for all sqls, is inside of ./sql path

# Run the system

docker-compose up --build

Thanks 

# Home Test

Hey! We are stoked that you are interested in joining the team.

We have crafted the following test to see how you approach pulling and manipulating of data. We want to get a general idea of how you approach some common types of problems that we encounter here

## Background
[spacexdata.com](https://docs.spacexdata.com/) provides an API to query attributes about SpaceX launches (https://github.com/r-spacex/SpaceX-API/tree/master/docs#rspacex-api-docs). For this exercise we are going to be working with one resource in particular:
- The [Starlink Schema](https://github.com/r-spacex/SpaceX-API/blob/master/docs/starlink/v4/schema.md)

*For this exercise, no need to pull directly from the API as we have a pull of historical data here in this repo in the starlink_historical_data.json*

## The Problem:
We want to be achieve a few goals:
  - To import the SpaceX Satellite data _as a time series_ into a database
  - To be able to query the data to determine the last known latitude/longitude of the satellite for a given time

## The Task (Part 1):

Stand up your favorite kind of database (and ideally it would be in a form that would be runnable by us, via something like docker-compose).

## The Task (Part 2):

Write code (ideally in Python) to import the relevant fields in starlink_historical_data.json as a time series. The relevant fields are:
    - spaceTrack.creation_date (represents the time that the lat/lon records were recorded)
    - longitude
    - latitude
    - id (this is the starlink satellite id)
Again, the goal is that we want to be able to query the database for the last known position for a given starlink satellite.
Don't hesitate to use any tools/tricks you know to load data quickly and easily!

## The Task (Part 3):

Write logic to fetch/query the last known position of a satellite (by id), given a time T. Include this query in your README or somewhere in the project submission

## Bonus Task (Part 4):

Write some logic (via a combination of query + application logic, most likely) to fetch from the database the _closest_ satellite at a given time T, and a given a position on a globe as a (latitude, longitude) coordinate.

No need to derive any fancy math for distances for a point on the globe to a position above the earth. You can just use the Haversine formula. Example library to help here https://github.com/mapado/haversine

### How to Submit

1. Run through it one last time to make sure it works!
2. Push the code up to your repo one last time (or save your working directory to a 'zip')
3. Reach out to us with your solution

### Questions

If you have any questions at all during the challenge do not hesitate to reach out! Whether it be a question about the requirements, submitting, anything, just send us a note!
