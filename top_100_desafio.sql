CREATE DATABASE movies;

CREATE TABLE movies_table(
    id INT,
    movie VARCHAR(200),
    release_year VARCHAR(4),
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

