CREATE DATABASE movies;

CREATE TABLE movies_table(
    id INT,
    movie VARCHAR(200),
    release_year INT,
    movie_director VARCHAR(50),
    PRIMARY KEY (id)
);

\copy movies_table FROM 'peliculas.csv' csv HEADER; 

CREATE TABLE casting_table(
    id INT,
    actor VARCHAR(200),
    FOREIGN KEY (id) REFERENCES movies_table(id)
);

\copy casting_table FROM 'reparto.csv' csv;

-- listamos los actores de Titanic
SELECT * FROM movies_table INNER JOIN casting_table on
movies_table.id=casting_table.id WHERE movie='Titanic';

-- listamos todas las peliculas de Harrison Ford
SELECT * FROM movies_table INNER JOIN casting_table on
movies_table.id=casting_table.id WHERE actor='Harrison Ford';

-- listamos a los directores y cuántas películas tienen en el ranking, los ordenamos de mayor cantidad a menor, y dejamos solo 10.
SELECT movie_director, count(*)                                                   FROM movies_table GROUP BY movie_director
ORDER BY count DESC
LIMIT 10;

-- indicaremos cuantos actores hay.
SELECT count(DISTINCT(actor)) FROM casting_table;

-- peliculas entre 1990 y 1999 incluidos, ordenados ascendente
SELECT movie FROM movies_table WHERE release_year>1989 AND release_year<2000
ORDER BY movie ASC;

-- listar reparto de películas lanzadas el 2001
SELECT actor FROM casting_table INNER JOIN movies_table on
movies_table.id=casting_table.id WHERE release_year=2001;

-- listar actores de pelicula mas nueva
SELECT actor FROM casting_table INNER JOIN movies_table on
movies_table.id=casting_table.id WHERE release_year=(
    SELECT MAX(release_year) 
    FROM movies_table
);