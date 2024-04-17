-- Вывести рейтинг фильмов по числу показов

WITH counted_showtimes AS(
    SELECT DISTINCT movie_id, count(*) OVER (PARTITION BY movie_id)
    FROM bs.showtimes
    ),
     counted_movies AS(
    SELECT title,
        CASE 
            WHEN EXISTS(SELECT * FROM bs.showtimes WHERE movie_id = mv.id)
            THEN cs.count
            ELSE 0
        END count
    FROM bs.movies AS mv
    LEFT JOIN counted_showtimes AS cs
        ON cs.movie_id = mv.id
     )
SELECT title, dense_rank() OVER (ORDER BY count DESC)
FROM counted_movies
