{{ config(materialized='table', schema='intermediate') }}

SELECT
    actor_id,
    first_name,
    last_name
FROM {{ ref('raw_actor') }}
