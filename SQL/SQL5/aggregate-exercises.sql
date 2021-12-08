use PersonalTrainer;

-- Use an aggregate to count the number of Clients.
-- 500 rows
-- --------------------
SELECT COUNT(*)
FROM Client;

-- Use an aggregate to count Client.BirthDate.
-- The number is different than total Clients. Why?
-- 463 rows
-- --------------------
SELECT COUNT(BirthDate)
FROM Client;

-- Group Clients by City and count them.
-- Order by the number of Clients desc.
-- 20 rows
-- --------------------
SELECT City, COUNT(*) AS NumClients
FROM Client
GROUP BY City;

-- Calculate a total per invoice using only the InvoiceLineItem table.
-- Group by InvoiceId.
-- You'll need an expression for the line item total: Price * Quantity.
-- Aggregate per group using SUM().
-- 1000 rows
-- --------------------
SELECT InvoiceId, SUM((Price * Quantity)) AS TotalPerInvoice
FROM InvoiceLineItem
GROUP BY InvoiceId;

-- Calculate a total per invoice using only the InvoiceLineItem table.
-- (See above.)
-- Only include totals greater than $500.00.
-- Order from lowest total to highest.
-- 234 rows
-- --------------------
SELECT InvoiceId, SUM((Price * Quantity)) AS TotalPerInvoice
FROM InvoiceLineItem
GROUP BY InvoiceId
HAVING SUM((Price * Quantity)) > 500
ORDER BY TotalPerInvoice;

-- Calculate the average line item total
-- grouped by InvoiceLineItem.Description.
-- 3 rows
-- --------------------
SELECT `Description`, AVG(Price*Quantity) AS AvgTotal
FROM InvoiceLineItem
GROUP BY `Description`;

-- Select ClientId, FirstName, and LastName from Client
-- for clients who have *paid* over $1000 total.
-- Paid is Invoice.InvoiceStatus = 2.
-- Order by LastName, then FirstName.
-- 146 rows
-- --------------------
SELECT c.ClientId, c.FirstName, c.LastNAme
FROM Client as c
INNER JOIN Invoice as i ON c.ClientId = i.ClientId
INNER JOIN InvoiceLineItem AS ili ON i.InvoiceId = ili.InvoiceId
WHERE i.InvoiceStatus = 2
GROUP BY c.ClientId, c.FirstName, c.LastName
HAVING SUM(ili.Price * ili.Quantity) > 1000
ORDER BY c.LastName, c.FirstName;

-- Count exercises by category.
-- Group by ExerciseCategory.Name.
-- Order by exercise count descending.
-- 13 rows
-- --------------------
SELECT ec.Name AS ExerciseCategory, COUNT(e.ExerciseId) AS NumExercises
FROM Exercise AS e
INNER JOIN ExerciseCategory AS ec ON e.ExerciseCategoryId = ec.ExerciseCategoryId
GROUP BY ec.Name
ORDER BY NumExercises DESC;

-- Select Exercise.Name along with the minimum, maximum,
-- and average ExerciseInstance.Sets.
-- Order by Exercise.Name.
-- 64 rows
-- --------------------
SELECT e.Name, MIN(ei.Sets) AS MinSets, MAX(ei.Sets) AS MaxSets, AVG(ei.Sets) AS AvgSets
FROM Exercise AS e
JOIN ExerciseInstance AS ei ON e.ExerciseId = ei.ExerciseId
GROUP BY e.ExerciseId
ORDER BY e.Name;

-- Find the minimum and maximum Client.BirthDate
-- per Workout.
-- 26 rows
-- Sample: 
-- WorkoutName, EarliestBirthDate, LatestBirthDate
-- '3, 2, 1... Yoga!', '1928-04-28', '1993-02-07'
-- --------------------
SELECT w.Name AS WorkoutName, MIN(c.BirthDate) AS EarliestBirthDate, MAX(c.BirthDate) AS LatestBirthDate
FROM Client AS c
JOIN ClientWorkout AS cw ON c.ClientId = cw.ClientId
JOIN Workout AS w ON cw.WorkoutId = w.WorkoutId
GROUP BY w.WorkoutId;

-- Count client goals.
-- Be careful not to exclude rows for clients without goals.
-- 500 rows total
-- 50 rows with no goals
-- --------------------
SELECT c.ClientId, COUNT(cg.GoalId) AS NumGoals
FROM Client AS c
LEFT JOIN ClientGoal AS cg ON c.ClientId = cg.ClientId
GROUP BY c.ClientId;

-- Select Exercise.Name, Unit.Name, 
-- and minimum and maximum ExerciseInstanceUnitValue.Value
-- for all exercises with a configured ExerciseInstanceUnitValue.
-- Order by Exercise.Name, then Unit.Name.
-- 82 rows
-- --------------------
SELECT e.Name AS ExerciseName, u.Name AS UnitName, MIN(eiuv.Value) AS MinVal, MAX(eiuv.Value) AS MaxVal
FROM Exercise AS e
JOIN ExerciseInstance AS ei ON e.ExerciseId = ei.ExerciseId
JOIN ExerciseInstanceUnitValue AS eiuv ON ei.ExerciseInstanceId = eiuv.ExerciseInstanceId
JOIN Unit AS u ON eiuv.UnitID = u.UnitId
GROUP BY e.ExerciseId, ExerciseName, UnitName
ORDER BY ExerciseName, UnitName;

-- Modify the query above to include ExerciseCategory.Name.
-- Order by ExerciseCategory.Name, then Exercise.Name, then Unit.Name.
-- 82 rows
-- --------------------
SELECT ec.Name AS CategoryName, e.Name AS ExerciseName, u.Name AS UnitName, MIN(eiuv.Value) AS MinVal, MAX(eiuv.Value) AS MaxVal
FROM Exercise AS e
JOIN ExerciseInstance AS ei ON e.ExerciseId = ei.ExerciseId
JOIN ExerciseInstanceUnitValue AS eiuv ON ei.ExerciseInstanceId = eiuv.ExerciseInstanceId
JOIN Unit AS u ON eiuv.UnitID = u.UnitId
JOIN ExerciseCategory AS ec ON e.ExerciseCategoryId = ec.ExerciseCategoryId
GROUP BY ec.ExerciseCategoryId, CategoryName, e.ExerciseId, ExerciseName, UnitName
ORDER BY CategoryName, ExerciseName, UnitName;

-- Select the minimum and maximum age in years for
-- each Level.
-- To calculate age in years, use the MySQL function DATEDIFF.
-- 4 rows
-- --------------------
SELECT l.Name AS LevelName, MIN(DATEDIFF(CURDATE(), c.BirthDate) / 365) AS MinAge, MAX(DATEDIFF(CURDATE(),c.BirthDate)/365) AS MaxAge
FROM Client AS c
JOIN ClientWorkout AS cw ON c.ClientId = cw.ClientId -- AND c.BirthDate IS NOT NULL
JOIN Workout AS w ON cw.WorkoutId = w.WorkoutId
JOIN Level AS l ON w.LevelId = l.LevelId
WHERE c.BirthDate IS NOT NULL
GROUP BY l.LevelId;

-- Stretch Goal!
-- Count logins by email extension (.com, .net, .org, etc...).
-- Research SQL functions to isolate a very specific part of a string value.
-- 27 rows (27 unique email extensions)
-- --------------------
SELECT SUBSTRING_INDEX(l.EmailAddress,'.',-1) AS EmailExtension, COUNT(l.ClientId) AS Logins
FROM Login l
GROUP BY EmailExtension;

-- Stretch Goal!
-- Match client goals to workout goals.
-- Select Client FirstName and LastName and Workout.Name for
-- all workouts that match at least 2 of a client's goals.
-- Order by the client's last name, then first name.
-- 139 rows
-- --------------------
SELECT c.FirstName, c.LastName, w.Name AS WorkoutName
FROM Workout AS w
JOIN WorkoutGoal AS wg ON w.WorkoutId = wg.WorkoutId
JOIN ClientGoal AS cg ON wg.GoalId = cg.GoalId
JOIN Client AS c ON c.ClientId = cg.ClientId
GROUP BY w.WorkoutId, c.ClientId
HAVING COUNT(cg.GoalId) >= 2
ORDER BY c.LastName, c.FirstName