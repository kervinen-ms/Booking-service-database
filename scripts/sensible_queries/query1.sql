-- Вывести фильмы, которые подростки могут 
--  посмотреть в кинотеатре 'Большой Экран'
WITH
    teens_allowed AS(
    SELECT mvs.id, mvs._age
    FROM bs.showtimes AS shws 
        FULL JOIN bs.movies AS mvs
            ON shws.movie_id = mvs.id
    WHERE shws.theater_id IN(
         SELECT id
         FROM bs.theaters
         WHERE nm = 'Большой Экран'
    )
    GROUP BY mvs.id
    HAVING mvs._age != '18+'
)
SELECT mvs.title, count(*) OVER() as cnt
FROM teens_allowed AS t 
    JOIN bs.movies AS mvs
        ON t.id = mvs.id
