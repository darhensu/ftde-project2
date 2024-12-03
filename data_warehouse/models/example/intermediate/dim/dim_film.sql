{{ config(materialized='table', schema='intermediate') }}

SELECT
    film_id,
    title,
    description,
    release_year,
    language_id,
    rental_duration,
    rental_rate,
    length,
    replacement_cost,
    rating,
    special_features
FROM {{ ref('raw_film') }}
