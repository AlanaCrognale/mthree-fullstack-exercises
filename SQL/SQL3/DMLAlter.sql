USE MovieCatalogue;

ALTER TABLE Actor
	ADD DateOfDeath Date;
    
UPDATE Actor SET
	DateOfDeath = '1994-03-04'
    WHERE ActorID = 3;

SELECT * FROM Actor;
SELECT * FROM Director;
SELECT * FROM Rating;
SELECT * FROM Genre;
SELECT * FROM Movie;
SELECT * FROM CastMembers;
