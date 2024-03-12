CREATE DATABASE record_company;
USE record_company;

CREATE TABLE bands (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE albums (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  release_year INT,
  band_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (band_id) REFERENCES bands(id)
);
CREATE TABLE songs(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
length FLOAT NOT NULL,
album_id INT NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(album_id) REFERENCES albums(id)
);

-- Select only the Names of all the Bands
SELECT name AS 'Band Name'
FROM bands
GROUP BY name;

-- Select the Oldest Album
SELECT * FROM albums
WHERE release_year IS NOT NULL
ORDER BY release_year
LIMIT 1;

-- Get all Bands that have Albums
SELECT DISTINCT bands.name AS 'Band Name' FROM albums
JOIN bands ON albums.band_id = bands.id
WHERE release_year IS NOT NULL;

-- Get all Bands that have No Albums
SELECT bands.name AS 'Band Name'
FROM bands
LEFT JOIN albums ON bands.id = albums.band_id
GROUP BY bands.id
HAVING COUNT(albums.id) = 0;

-- Get the Longest Album
SELECT albums.name AS 'Name',
albums.release_year AS 'Release Year',
SUM(songs.length) AS 'Duration'
FROM albums
JOIN songs ON albums.id = songs.album_id
GROUP BY albums.name , albums.release_year
ORDER BY SUM(songs.length) DESC
LIMIT 1;

-- Update the Release Year of the Album with no Release Year
UPDATE albums
SET release_year = 1986
WHERE id = 4;
SELECT * FROM albums;

--  Insert a record for your favorite Band and one of their Albums
INSERT INTO bands(name)
VALUE('The Backseat lovers');
INSERT INTO albums (name, release_year, band_id)
VALUE ('When We Were Friends', 2019, 8);
SELECT * FROM albums
ORDER BY id DESC LIMIT 1; 

-- Delete the Band and Album you added in #8
DELETE FROM albums
WHERE id = 19;
DELETE FROM bands
WHERE id = 8;

-- Get the Average Length of all Songs
SELECT AVG(length) AS 'Average Song Duration' FROM songs;

-- Select the longest Song off each Album
SELECT albums.name AS 'Album',
albums.release_year AS 'Release Year',
MAX(songs.length) AS 'Duration'
FROM albums
JOIN songs ON albums.id = songs.album_id
GROUP BY albums.id;

--  Get the number of Songs for each Band
SELECT bands.name AS 'Band',
COUNT(songs.id) AS 'Number of Songs'
FROM songs
JOIN albums ON songs.album_id = albums.id
JOIN bands ON albums.band_id = bands.id
GROUP BY band_id;






