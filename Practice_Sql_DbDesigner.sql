CREATE DATABASE Practice_Sql_DbDesigner

USE Practice_Sql_DbDesigner

CREATE TABLE Movies (
	Id int Primary Key Identity,
	[Name] nvarchar(50),
	Duration nvarchar(50),
	ReleaseDate datetime,
	Rating float
)

CREATE TABLE Directors (
	Id int Primary Key Identity,
	[Name] nvarchar(50),
	Surname nvarchar(50)
)

CREATE TABLE Actors (
	Id int Primary Key Identity,
	[Name] nvarchar(50),
	Surname nvarchar(50),
	Age int,
	[Role] nvarchar(50)
)

CREATE TABLE Genres (
	Id int Primary Key Identity,
	Name varchar(50),
)

CREATE TABLE ActorsMovies (
	Id int Primary Key Identity,
	MoviesId int Foreign Key References Movies (id),
	ActorsId int Foreign Key References Actors (id)
)

CREATE TABLE DirectorsMovies (
	Id int Primary Key Identity,
	MoviesId int Foreign Key References Movies (id),
	DirectorsId int Foreign Key References Directors (id)
)

CREATE TABLE GenresMovies (
	Id int Primary Key Identity,
	MoviesId int Foreign Key References Movies (id),
	GenresId int Foreign Key References Genres (id),
)

Insert into Movies
Values  ('The Dark Knight', '02:32:00', 18/07/2008, 9.1), 
		('The Matrix', '02:16:00', 24/03/1999, 8.7), 
		('Men in Black: International', '01:54:00', 11/06/2019, 5.1)

Insert into Directors
Values  ('Christopher', 'Nolan'), 
		('Lana', 'Wachowski'), ('Lilly', 'Wachowski'), 
		('F', 'Gary Gray')

Insert into DirectorsMovies
Values  (1, 1), 
		(2, 2), (2, 3), 
		(3, 4)

Insert into Actors
Values  ('Christian', 'Bale', 34, 'Bruce Wayne'),
		('Heath', 'Ledger', 29, 'Joker'),
		('Aaron', 'Eckhart', 40, 'Harvey Dent'), 
		('Michael', 'Caine', 75, 'Alfred'), 
		('Keanu', 'Reeves', 35, 'Neo'), 
		('Laurence', 'Fishburne', 38, 'Morpheus'), 
		('Carrie-Anne', 'Moss', 32, 'Trinity'), 
		('Hugo', 'Weaving', 39, 'Agent Smith'), 
		('Chris', 'Hemsworth', 36, 'Agent H'), 
		('Tessa', 'Thompson', 36, 'Agent M'), 
		('Kumail', 'Nanjiani', 40, 'Pawny'), 
		('Rebecca', 'Ferguson', 36, 'Riza')

Insert into ActorsMovies
Values  (1, 1), (1, 2), (1, 3), (1, 4), 
		(2, 5), (2, 6), (2, 7), (2, 8), 
		(3, 9), (3, 10), (3, 11), (3, 12)

Insert into Genres
Values ('Action'), ('Crime'), ('Drama'), ('Sci-Fi'), ('Acventure'), ('Comedy')

Insert into GenresMovies
Values  (1, 1), (1, 2), (1, 3), 
		(2, 1), (2, 4), 
		(3, 1), (3, 5), (3, 6)

Select  m.Name,
		m.Rating,
		g.Name as 'Genre',
		d.Name as 'Directors Name',
		d.Surname as 'Directors Surname',
		a.Name as 'Actors Name',
		a.Surname as 'Actors Surname'
	from Movies m
join GenresMovies gm on gm.MoviesId = m.Id
join Genres g on g.Id = gm.GenresId
join ActorsMovies am on am.MoviesId = m.Id
join Actors a on a.Id = am.ActorsId
join DirectorsMovies dm on dm.MoviesId = m.Id
join Directors d on d.Id = dm.DirectorsId
where m.Rating > 6

Select  m.Name,
		m.Rating,
		g.Name as 'Genre'
	from Movies m
join GenresMovies gm on gm.MoviesId = m.Id
join Genres g on g.Id = gm.GenresId
where g.Name like '%a%'

Select  m.Name,
		m.Rating,
		m.Duration,
		g.Name as 'Genre'
	from Movies m
join GenresMovies gm on gm.MoviesId = m.Id
join Genres g on g.Id = gm.GenresId
where len(m.Name) > 10

Select  m.Name,
		m.Rating,
		g.Name as 'Genre',
		d.Name as 'Directors Name',
		d.Surname as 'Directors Surname',
		a.Name as 'Actors Name',
		a.Surname as 'Actors Surname'
	from Movies m
join GenresMovies gm on gm.MoviesId = m.Id
join Genres g on g.Id = gm.GenresId
join ActorsMovies am on am.MoviesId = m.Id
join Actors a on a.Id = am.ActorsId
join DirectorsMovies dm on dm.MoviesId = m.Id
join Directors d on d.Id = dm.DirectorsId
WHERE m.Rating > (SELECT AVG(Rating) FROM Movies)
order by m.Rating DESC