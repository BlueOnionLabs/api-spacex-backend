CREATE TABLE public.spacex (creation_date timestamp, latitude double precision, longitude double precision, id text) PARTITION BY RANGE(creation_date);

CREATE INDEX spacex_id_idx ON public.spacex USING btree (id, creation_date DESC);