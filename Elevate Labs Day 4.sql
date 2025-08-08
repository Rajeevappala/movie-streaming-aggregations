
--- Count total movies watched by each user

SELECT 
    u.UserID,
    u.Name,
    COUNT(wh.MovieID) AS TotalMoviesWatched
FROM Users u
JOIN WatchHistory wh ON u.UserID = wh.UserID
GROUP BY u.UserID, u.Name


--- Find average rating given by each user

SELECT 
    u.UserID,
    u.Name,
    AVG(r.Rating) AS AvgRating
FROM Users u
JOIN Reviews r ON u.UserID = r.UserID
GROUP BY u.UserID, u.Name
HAVING AVG(r.Rating) >= 4;


--- Count number of ratings per movie

SELECT 
    m.MovieID,
    m.Title,
    COUNT(r.Rating) AS RatingCount
FROM Movies m
JOIN Reviews r ON m.MovieID = r.MovieID
GROUP BY m.MovieID, m.Title
HAVING COUNT(r.Rating) >= 2;

--- Movies with average rating above 4.5
SELECT 
    m.MovieID,
    m.Title,
    AVG(r.Rating) AS AvgRating
FROM Movies m
JOIN Reviews r ON m.MovieID = r.MovieID
GROUP BY m.MovieID, m.Title
HAVING AVG(r.Rating) > 4.5;


--- Total watch time for each user

SELECT 
    u.UserID,
    u.Name,
    SUM(m.Duration) AS TotalWatchTime
FROM Users u
JOIN WatchHistory wh ON u.UserID = wh.UserID
JOIN Movies m ON wh.MovieID = m.MovieID
GROUP BY u.UserID, u.Name
HAVING SUM(m.Duration) > 300;

--- Number of users in each subscription plan

SELECT 
    s.PlanName,
    COUNT(s.UserID) AS TotalUsers
FROM Subscriptions s
GROUP BY s.PlanName
HAVING COUNT(s.UserID) >= 1;

--- Highest rating for each movie

SELECT 
    m.MovieID,
    m.Title,
    MAX(r.Rating) AS HighestRating
FROM Movies m
JOIN Reviews r ON m.MovieID = r.MovieID
GROUP BY m.MovieID, m.Title
HAVING MAX(r.Rating) = 5;

--- Total movies watched by subscription plan

SELECT 
    s.PlanName,
    COUNT(wh.MovieID) AS TotalMoviesWatched
FROM Subscriptions s
JOIN Users u ON s.UserID = u.UserID
JOIN WatchHistory wh ON u.UserID = wh.UserID
GROUP BY s.PlanName
HAVING COUNT(wh.MovieID) > 1;

--- Average movie duration by genre

SELECT 
    g.GenreName,
    AVG(m.Duration) AS AvgDuration
FROM Genres g
JOIN MovieGenres mg ON g.GenreID = mg.GenreID
JOIN Movies m ON mg.MovieID = m.MovieID
GROUP BY g.GenreName
HAVING AVG(m.Duration) > 120;


--- Users who watched more than 2 movies in the same genre
SELECT 
    u.Name,
    g.GenreName,
    COUNT(*) AS MoviesWatched
FROM Users u
JOIN WatchHistory wh ON u.UserID = wh.UserID
JOIN Movies m ON wh.MovieID = m.MovieID
JOIN MovieGenres mg ON m.MovieID = mg.MovieID
JOIN Genres g ON mg.GenreID = g.GenreID
GROUP BY u.Name, g.GenreName
HAVING COUNT(*) > 2;
