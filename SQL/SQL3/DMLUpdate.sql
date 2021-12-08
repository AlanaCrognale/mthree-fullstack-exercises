USE MovieCatalogue;

UPDATE Movie SET
	Title = 'Ghostbusters (1984)',
    ReleaseDate = '1984-06-08'
    WHERE MovieID = 3;

UPDATE Genre SET
	GenreName = 'Action/Adventure'
    WHERE GenreID = 1;


SELECT * FROM Actor;
SELECT * FROM Director;
SELECT * FROM Rating;
SELECT * FROM Genre;
SELECT * FROM Movie;
SELECT * FROM CastMembers;