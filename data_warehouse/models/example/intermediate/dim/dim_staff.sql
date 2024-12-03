{{ config(materialized='table', schema='intermediate') }}

SELECT
    staff_id,
    first_name,
    last_name,
    email,
    store_id
FROM {{ ref('raw_staff') }}
