{{ config(materialized='table', schema='intermediate') }}

SELECT
    actor_id,
    film_id
FROM {{ ref('raw_film_actor') }}
