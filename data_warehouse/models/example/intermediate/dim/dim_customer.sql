{{ config(materialized='table', schema='intermediate') }}

SELECT
    customer_id,
    first_name,
    last_name,
    email,
    address_id,
    active
FROM {{ ref('raw_customer') }}
