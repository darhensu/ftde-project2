{{ config(materialized='table') }}{{ config(materialized='table', schema='intermediate') }}
SELECT
    rental_id,
    rental_date,
    return_date,
    customer_id,
    staff_id,
    inventory_id
FROM {{ ref('raw_rental') }}
