-- How many monthly total revenue ?

{{ config(materialized='table', schema='mart') }}

SELECT
    f.title AS film_title,
    SUM(p.amount) AS total_revenue
FROM {{ ref('dim_film') }} f
JOIN {{ ref('dim_inventory') }} i ON f.film_id = i.film_id
JOIN {{ ref('fact_payment') }} p ON p.payment_id = i.inventory_id  
GROUP BY film_title
ORDER BY total_revenue DESC
LIMIT 1
