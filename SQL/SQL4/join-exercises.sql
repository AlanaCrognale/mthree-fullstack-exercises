USE PersonalTrainer;
-- Select all columns from ExerciseCategory and Exercise.
-- The tables should be joined on ExerciseCategoryId.
-- This query returns all Exercises and their associated ExerciseCategory.
-- 64 rows
SELECT *
	FROM ExerciseCategory
    INNER JOIN Exercise ON ExerciseCategory.ExerciseCategoryId = Exercise.ExerciseCategoryId;
-- --------------------
-- Select ExerciseCategory.Name and Exercise.Name
-- where the ExerciseCategory does not have a ParentCategoryId (it is null).
-- Again, join the tables on their shared key (ExerciseCategoryId).
-- 9 rows
SELECT ExerciseCategory.Name, Exercise.Name
	FROM ExerciseCategory
    INNER JOIN Exercise ON ExerciseCategory.ExerciseCategoryId = Exercise.ExerciseCategoryId
    WHERE ExerciseCategory.ParentCategoryId IS NULL;
-- --------------------
-- The query above is a little confusing. At first glance, it's hard to tell
-- which Name belongs to ExerciseCategory and which belongs to Exercise.
-- Rewrite the query using an aliases. 
-- Alias ExerciseCategory.Name as 'CategoryName'.
-- Alias Exercise.Name as 'ExerciseName'.
-- 9 rows
SELECT ExerciseCategory.Name as CategoryName, Exercise.Name as ExerciseName
	FROM ExerciseCategory
    INNER JOIN Exercise ON ExerciseCategory.ExerciseCategoryId = Exercise.ExerciseCategoryId
    WHERE ExerciseCategory.ParentCategoryId IS NULL;
-- --------------------
-- Select FirstName, LastName, and BirthDate from Client
-- and EmailAddress from Login 
-- where Client.BirthDate is in the 1990s.
-- Join the tables by their key relationship. 
-- What is the primary-foreign key relationship?
-- 35 rows
SELECT c.FirstName, c.LastName, c.BirthDate, l.EmailAddress
	FROM `Client` as c
    INNER JOIN Login as l ON c.ClientId = l.ClientId
    WHERE c.BirthDate BETWEEN '1990-01-01' AND '1999-12-31';
-- --------------------
-- Select Workout.Name, Client.FirstName, and Client.LastName
-- for Clients with LastNames starting with 'C'?
-- How are Clients and Workouts related?
-- 25 rows
SELECT w.Name, c.FirstName, c.LastName
	FROM `Client` as c
    INNER JOIN ClientWorkout as cw ON c.ClientId = cw.ClientId
    INNER JOIN Workout as w ON cw.WorkoutId = w.WorkoutId
    WHERE c.LastName LIKE 'C%';
-- --------------------
-- Select Names from Workouts and their Goals.
-- This is a many-to-many relationship with a bridge table.
-- Use aliases appropriately to avoid ambiguous columns in the result.
SELECT w.Name as WorkoutName, g.Name as GoalName
	FROM Workout as w
    INNER JOIN WorkoutGoal as wg ON w.WorkoutId = wg.WorkoutId
    INNER JOIN Goal as g ON wg.GoalId = g.GoalId;
-- --------------------
-- Select FirstName and LastName from Client.
-- Select ClientId and EmailAddress from Login.
-- Join the tables, but make Login optional.
-- 500 rows
SELECT c.FirstName, c.LastName, l.ClientId, l.EmailAddress
	FROM `Client` as c
    LEFT JOIN Login as l ON c.ClientId = l.ClientId;
-- --------------------
-- Using the query above as a foundation, select Clients
-- who do _not_ have a Login.
-- 200 rows
SELECT c.FirstName, c.LastName, l.ClientId, l.EmailAddress
	FROM `Client` as c
    LEFT JOIN Login as l ON c.ClientId = l.ClientId
    WHERE l.ClientId IS NULL;
-- --------------------
-- Does the Client, Romeo Seaward, have a Login?
-- Decide using a single query.
-- nope :(
SELECT c.FirstName, c.LastName, l.ClientId, l.EmailAddress
	FROM `Client` as c
    LEFT JOIN Login as l ON c.ClientId = l.ClientId
    WHERE c.FirstName = 'Romeo' AND c.LastName = 'Seaward';
-- --------------------
-- Select ExerciseCategory.Name and its parent ExerciseCategory's Name.
-- This requires a self-join.
-- 12 rows
SELECT ec.Name as CategoryName, ecp.Name as ParentName
	FROM ExerciseCategory as ec
    INNER JOIN ExerciseCategory as ecp ON ec.ParentCategoryId = ecp.ExerciseCategoryId;
-- --------------------
-- Rewrite the query above so that every ExerciseCategory.Name is
-- included, even if it doesn't have a parent.
-- 16 rows
SELECT ec.Name as CategoryName, ecp.Name as ParentName
	FROM ExerciseCategory as ec
    LEFT JOIN ExerciseCategory as ecp ON ec.ParentCategoryId = ecp.ExerciseCategoryId;
-- --------------------
-- Are there Clients who are not signed up for a Workout?
-- 50 rows
SELECT c.FirstName, c.LastName, cw.WorkoutId
	FROM `Client` as c 
    LEFT JOIN ClientWorkout as cw ON c.ClientId = cw.ClientId
    WHERE cw.WorkoutID IS NULL;
-- --------------------
-- Which Beginner-Level Workouts satisfy at least one of Shell Creane's Goals?
-- Goals are associated to Clients through ClientGoal.
-- Goals are associated to Workouts through WorkoutGoal.
-- 6 rows, 4 unique rows
SELECT w.Name
	FROM `Client` as c
	INNER JOIN ClientGoal as cg ON c.ClientId = cg.ClientId
    INNER JOIN WorkoutGoal as wg ON cg.GoalId = wg.GoalId
    INNER JOIN Workout as w ON wg.WorkoutId = w.WorkoutId
    INNER JOIN `Level` as l ON w.LevelId = l.LevelId
    WHERE c.FirstName = 'Shell' AND c.LastName = 'Creane' AND l.Name = 'Beginner';
-- --------------------
-- Select all Workouts. 
-- Join to the Goal, 'Core Strength', but make it optional.
-- You may have to look up the GoalId before writing the main query.
-- If you filter on Goal.Name in a WHERE clause, Workouts will be excluded.
-- Why?
-- 26 Workouts, 3 Goals
SELECT w.Name as WorkoutName, g.Name as GoalName
	FROM Workout as w
	LEFT JOIN WorkoutGoal as wg ON w.WorkoutId = wg.WorkoutId AND wg.GoalId = 10
    LEFT JOIN Goal as g ON wg.GoalId = g.GoalId;
-- --------------------
-- The relationship between Workouts and Exercises is... complicated.
-- Workout links to WorkoutDay (one day in a Workout routine)
-- which links to WorkoutDayExerciseInstance 
-- (Exercises can be repeated in a day so a bridge table is required) 
-- which links to ExerciseInstance 
-- (Exercises can be done with different weights, repetions,
-- laps, etc...) 
-- which finally links to Exercise.
-- Select Workout.Name and Exercise.Name for related Workouts and Exercises.
SELECT w.Name as WorkoutName, e.Name as ExerciseName
	FROM Workout as w
	INNER JOIN WorkoutDay as wd ON w.WorkoutId = wd.WorkoutId
    INNER JOIN WorkoutDayExerciseInstance as wdei ON wd.WorkoutDayId = wdei.WorkoutDayId
    INNER JOIN ExerciseInstance as ei ON wdei.ExerciseInstanceId = ei.ExerciseInstanceId
    INNER JOIN Exercise AS e ON ei.ExerciseId = e.ExerciseId;
-- --------------------
-- An ExerciseInstance is configured with ExerciseInstanceUnitValue.
-- It contains a Value and UnitId that links to Unit.
-- Example Unit/Value combos include 10 laps, 15 minutes, 200 pounds.
-- Select Exercise.Name, ExerciseInstanceUnitValue.Value, and Unit.Name
-- for the 'Plank' exercise. 
-- How many Planks are configured, which Units apply, and what 
-- are the configured Values?
-- 4 rows, 1 Unit, and 4 distinct Values
SELECT e.Name AS ExerciseName, eiuv.`Value` AS `Value`, u.Name AS Unit
FROM  Unit AS U 
INNER JOIN ExerciseInstanceUnitValue AS eiuv ON u.UnitId = eiuv.UnitId
INNER JOIN ExerciseInstance AS ei ON eiuv.ExerciseInstanceId = ei.ExerciseInstanceId
INNER JOIN Exercise as e ON ei.ExerciseId = e.ExerciseId
WHERE e.Name = 'Plank';
-- --------------------