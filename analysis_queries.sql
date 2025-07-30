use [Netflix data]

select * from netflix

-- Q1_Movie_vs_TV
SELECT type, COUNT(*) FROM netflix GROUP BY type;

-- Q2_Common_Ratings
SELECT type, rating AS most_common_rating
FROM (
    SELECT type, rating, 
           COUNT(*) AS rating_count,
           RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS rank
    FROM netflix
    GROUP BY type, rating
) sub
WHERE rank = 1;

-- Q3_Movies_2020
SELECT * FROM netflix WHERE type = 'Movie' AND release_year = 2020;

-- Q4_Top5_Countries
SELECT TOP 5 country, COUNT(*) AS count FROM netflix GROUP BY country ORDER BY count DESC;

-- Q5_Longest_Movie
SELECT * from netflix
WHERE type = 'Movie' ORDER BY CAST(SUBSTRING(duration FROM '\d+') AS INTEGER) DESC;

-- Q6_Content_Last5Years
SELECT * FROM netflix_titles WHERE EXTRACT(YEAR FROM date_added) >= (SELECT MAX(EXTRACT(YEAR FROM date_added)) FROM netflix_titles) - 4;

-- Q7_RajivChilaka_Content
SELECT * FROM netflix_titles WHERE director = 'Rajiv Chilaka';

-- Q8_TVShows_Over5Seasons
SELECT * FROM netflix_titles WHERE type = 'TV Show' AND CAST(SUBSTRING(duration FROM '\d+') AS INTEGER) > 5;

-- Q9_Content_Per_Genre
-- Requires genre normalization -- Suggest: explode listed_in and use GROUP BY genre;

-- Q10_Top5_Years_India
SELECT release_year, COUNT(*) AS total FROM netflix_titles WHERE country LIKE '%India%' GROUP BY release_year ORDER BY total DESC LIMIT 5;

-- Q11_Documentary_Movies
SELECT * FROM netflix WHERE type = 'Movie' AND listed_in LIKE '%Documentaries%';

-- Q12_No_Director_Content
SELECT * FROM netflix WHERE director IS NULL;

-- Q13_SalmanKhan_Movies
SELECT * FROM netflix WHERE type = 'Movie' AND release_year >= 2012 AND cast LIKE '%Salman Khan%';

-- Q14_Top10_Actors_India
-- Requires exploding cast column. Not directly possible in basic SQL without a helper table;

-- Q15_Content_Label_Counts
-- Use: SELECT COUNT(*), CASE WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad' ELSE 'Good' END AS content_label FROM netflix_titles GROUP BY content_label;