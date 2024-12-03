-- Who is the actor who plays the most roles in films ?

{{ config(materialized='table', schema='mart') }}

SELECT 
   
    COUNT(*) AS total_roles
FROM {{ ref('dim_actor') }} a
JOIN {{ ref('dim_film_actor') }} fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY total_roles DESC
LIMIT 1
