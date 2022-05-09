# Blue Onion Labs Take Home Test

## The Task (Part 1):

docker-compose -f ./tasks/create_db/psql.yml up

## The Task (Part 2):

Notebook created to be easier to understand the steps used to load the data as this is a one-time-only process. In case this was something that would run on production on a daily basis, the code would need to be refactored, with logging added and functions encapsulated for easier maintance and debugging.

- File: ./tasks/loader/loader.ipynb

## The Task (Part 3):

Query written with 2 variables to be replaced:
- File: last_position_by_id.sql
- var_id: satellite id to query position
- var_creation_date: a time T to pick the last know position of a satellite. Must be informed in the YYYY-MM-DD HH:MM:SS format.

## Bonus Task (Part 4):

Notebook created with a function to be called with two variables:
- File: ./tasks/loader/loader.ipynb
- position: (latitude, longitude) tupple.
- timestamp: timestamp in the YYYY-MM-DD HH:MM:SS format