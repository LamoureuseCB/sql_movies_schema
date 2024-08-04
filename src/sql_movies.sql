
-- Задача 1: Жанры с наибольшим числом фильмов
-- Необходимо определить топ N жанров (например, N = 3) с наибольшим числом фильмов в базе данных. Вывести названия жанров и количество фильмов для каждого жанра.
--Команда LIMIT задает ограничение на количество записей, выбираемых из базы данных. ???
select genres.name,
       count(movie_id) as Количество_фильмов
from genres
         join movies_genres on genres.id = movies_genres.genre_id
group by genres.name
order by Количество_фильмов desc
limit 3;

-- Задача 2: Средний рейтинг фильмов по жанрам
-- Для каждого жанра нужно вычислить средний рейтинг всех фильмов, относящихся к этому жанру. Вывести названия жанров и средние рейтинги в порядке убывания рейтинга.
select genres.name        as Жанр,
       avg(movies.rating) as Средний_рейтинг
from movies
         join movies_genres on movies.id = movies_genres.movie_id
         join genres on genres.id = movies_genres.genre_id
group by genres.name
order by Средний_рейтинг desc;

-- Задача 3: Фильмы с наивысшим рейтингом по годам:
-- Для каждого года нужно вычислить фильм с наивысшим рейтингом. Выведите год выпуска, название фильма и рейтинг.
select release_year as Год_выпуска,
       title        as Название_фильма,
       max(rating)  as Рейтинг
from movies
group by release_year, title
order by Год_выпуска;

-- Задача 4: Жанры фильмов в релизах по годам
-- Для каждого года релиза фильмов нужно подсчитать, сколько фильмов разных жанров было выпущено. Вывести год, название жанра и количество фильмов для каждого года в порядке убывания количества фильмов.
select release_year                  as Год_выпуска,
       genres.name                   as Жанр,
       count(movies_genres.movie_id) as Количество_фильмов
from movies
         join movies_genres on movies.id = movies_genres.movie_id
         join genres on genres.id = movies_genres.genre_id
group by release_year, genres.name
order by Количество_фильмов desc;

-- Задача 5: Жанры, в которых выпущено более 5 фильмов:
-- Напишите запрос, который найдет жанры, в которых было выпущено более 5 фильмов.
select genres.name      as Жанр,
       count(movies.id) as Количество_фильмов
from genres
         join movies_genres on genres.id = movies_genres.genre_id
         join movies on movies.id = movies_genres.movie_id
group by genres.name
having count(movies.id) > 5;

-- Задача 6: Рейтинг и количество фильмов по годам
-- Для каждого года релиза фильмов посчитать средний рейтинг и общее количество выпущенных фильмов. Вывести год, средний рейтинг и количество фильмов для каждого года в порядке убывания рейтинга.
select movies.release_year as Год,
       avg(movies.rating)  as Средний_рейтинг,
       count(movies.id)    as Количество_фильмов
from movies
group by movies.release_year
order by Средний_рейтинг desc;

-- Задача 7: Фильмы с высоким рейтингом по жанру
-- Для заданного жанра (к примеру Боевик) вывести список фильмов этого жанра с рейтингом выше определенного значения (например, 8.0). Вывести название фильма, год релиза и рейтинг.
select movies.title        as Название_фильма,
       movies.release_year as Год,
       movies.rating       as Рейтинг
from movies
         join movies_genres on movies.id = movies_genres.movie_id
         join genres on genres.id = movies_genres.genre_id
where genres.name = 'Боевик'
  and movies.rating > 8.0;

-- Задача 8: Фильмы с наивысшим и наименьшим рейтингом:
-- Напишите запрос, который найдет название и рейтинг самого высоко и самого низко оцененных фильмов.
-- объединение нескольких  результатов возможно с union all , использованы вложенные запросы ????
select title as Название_фильма, rating as Рейтинг
from movies
where rating = (select max(rating) from movies)

union all

select title as Название_фильма, rating as Рейтинг
from movies
where rating = (select min(rating) from movies);
