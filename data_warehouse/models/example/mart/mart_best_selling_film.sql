-- What is the best selling film ?

{{ config(materialized='table', schema='mart') }}

SELECT f.title, SUM(p.amount) AS total_revenue
FROM {{ ref('dim_film') }}  f
JOIN {{ ref('dim_inventory') }} i ON f.film_id = i.film_id
JOIN {{ ref('dim_rental') }}  r ON i.inventory_id = r.inventory_id
JOIN {{ ref('fact_payment') }} p ON r.rental_id = p.rental_id
GROUP BY f.title
ORDER BY total_revenue DESC
LIMIT 1
