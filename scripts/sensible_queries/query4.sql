-- Вывести 3 самых дешёвых тарифа в каждом кинотеатре

WITH ranked_tariffs AS(
    SELECT nm, theater_id,
        rank() OVER (PARTITION BY theater_id ORDER BY ticket_price)
    FROM bs.tariffs)
SELECT trf.nm AS tariff, thtr.nm AS theater, rank
FROM ranked_tariffs AS trf 
    JOIN bs.theaters AS thtr
    ON trf.theater_id = thtr.id  
WHERE rank <= 3
