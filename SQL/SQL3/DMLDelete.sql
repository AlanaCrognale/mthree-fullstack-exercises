USE MovieCatalogue;

DELETE FROM CastMembers
	WHERE MovieID = 1;
    
DELETE FROM Movie
	WHERE MovieID = 1;

SELECT * FROM Actor;
SELECT * FROM Director;
SELECT * FROM Rating;
SELECT * FROM Genre;
SELECT * FROM Movie;
SELECT * FROM CastMembers;
