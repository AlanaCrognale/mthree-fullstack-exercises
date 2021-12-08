USE PersonalTrainer;

-- Activity 1
SELECT *
FROM Exercise;

-- Activity 2
SELECT *
FROM Client;

-- Activity 3
SELECT *
FROM Client
WHERE City = 'Metairie';

-- Activity 4
SELECT *
FROM Client
WHERE ClientId = '818u7faf-7b4b-48a2-bf12-7a26c92de20c';

-- Activity 5
SELECT *
FROM Goal;

-- Activity 6
SELECT Name, LevelId
FROM Workout;

-- Activity 7
SELECT Name, LevelId, Notes
FROM Workout
WHERE LevelId = 2;

-- Activity 8
SELECT FirstName, LastName, City
FROM Client
WHERE City IN ('Metairie','Kenner','Gretna');

-- Activity 9
SELECT FirstName, LastName, BirthDate
FROM Client
WHERE BirthDate BETWEEN '1980-01-01' AND '1989-12-31';

-- Activity 10
SELECT FirstName, LastName, BirthDate
FROM Client
WHERE BirthDate >= '1980-01-01' AND BirthDate <= '1989-12-31';

-- Activity 11
SELECT *
FROM Login
WHERE EmailAddress LIKE '%.gov';

-- Activity 12
SELECT *
FROM Login
WHERE EmailAddress NOT LIKE '%.com';

-- Activity 13
SELECT FirstName, LastName
FROM Client
WHERE BirthDate IS NULL;

-- Activity 14
SELECT Name
FROM ExerciseCategory
WHERE ParentCategoryId IS NOT NULL;

-- Activity 15
SELECT Name, Notes
FROM Workout
WHERE LevelID = 3 AND Notes LIKE '%you%';

-- Activity 16
SELECT FirstName, LastName, City
FROM Client
WHERE (LastName LIKE 'L%' or LastName LIKE 'M%' or LastName LIKE 'N%') AND City = 'LaPlace';

-- Activity 17
SELECT InvoiceID, Description, Price, Quantity, ServiceDate, (Price * Quantity) as LineItemTotal
FROM InvoiceLineItem
WHERE (Price * Quantity) BETWEEN 15 AND 25;

-- Activity 18
SELECT *
FROM Client
WHERE FirstName = 'Estrella' AND LastName = 'Bazely';

SELECT *
FROM Login
WHERE ClientId = '87976c42-9226-4bc6-8b32-23a8cd7869a5';

-- Activity 19
SELECT WorkoutId
FROM Workout
WHERE Name = 'This Is Parkour';

SELECT GoalId
FROM WorkoutGoal
WHERE WorkoutId = 12;

SELECT Name
FROM Goal
WHERE GoalId IN ('3','8','15');

