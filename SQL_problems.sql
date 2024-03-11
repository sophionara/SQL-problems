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
create table songs(
id int not null auto_increment,
name varchar(255) not null,
length float not null,
album_id int not null,
primary key(id),
foreign key(album_id) references albums(id)
);
-- Select only the Names of all the Bands
select name as 'Band Name'
from bands
group by name;

-- Select the Oldest Album
select * from albums
where release_year is not null
order by release_year
limit 1;
-- Get all Bands that have Albums

select distinct bands.name as 'Band Name' from albums
join bands on albums.band_id = bands.id
where release_year is not null;

-- Get all Bands that have No Albums
SELECT bands.name AS 'Band Name'
FROM bands
LEFT JOIN albums ON bands.id = albums.band_id
GROUP BY bands.id
HAVING COUNT(albums.id) = 0;
-- Get the Longest Album

select albums.name as "Name", 
albums.release_year as "Release Year",
SUM(songs.length) as "Duration" 
from albums
join songs on albums.id = songs.album_id
GROUP BY albums.name, albums.release_year
order by sum(songs.length) desc
limit 1;

-- Update the Release Year of the Album with no Release Year
update albums
set release_year = 1986
where id = 4;
select * from albums;

--  Insert a record for your favorite Band and one of their Albums
insert into bands(name)
value('The Backseat lovers');
insert into albums (name, release_year, band_id)
value ('When We Were Friends', 2019, 8);
select * from albums
order by id desc limit 1; 
-- Delete the Band and Album you added in #8
delete from albums
where id = 19;
delete from bands
where id = 8;
-- Get the Average Length of all Songs
select avg(length) as 'Average Song Duration' from songs;
-- Select the longest Song off each Album
select albums.name as 'Album',
albums.release_year as 'Release Year',
max(songs.length) as 'Duration'
from albums
join songs on albums.id = songs.album_id
group by albums.id;

--  Get the number of Songs for each Band
select bands.name as 'Band', count(songs.id) as 'Number of Songs' from songs
join albums on songs.album_id = albums.id
join bands on albums.band_id = bands.id
group by band_id;






