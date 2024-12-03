-- Who is the actor who plays the most roles in films ?

{{ config(materialized='table', schema='mart') }}

SELECT
    a.first_name || ' ' || a.last_name AS actor_name,
    COUNT(fa.film_id) AS total_roles
FROM {{ ref('dim_actor') }} a
JOIN {{ ref('dim_film_actor') }} fa ON a.actor_id = fa.actor_id
GROUP BY actor_name
ORDER BY total_roles DESC
LIMIT 1
