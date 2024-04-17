-- Вывести фильмы, вышедшие в 1982 в хронологическом порядке

SELECT title, count(*) OVER()
FROM bs.movies
WHERE date_part('year', premiere_date) = 1982
ORDER BY premiere_date

