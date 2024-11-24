-- Select the database to use for this session
USE netflix_movies;

-- Create a table `net_title` to store Netflix movies and shows data
CREATE TABLE `net_title` (
  `show_id` varchar(10) NULL,               -- Unique identifier for each show
  `type` varchar(10) NULL,                 -- Type of content: 'Movie' or 'TV Show'
  `title` varchar(150) NULL,               -- Title of the content
  `director` varchar(208) NULL,            -- Name of the director(s) (if available)
  `cast` varchar(1000) NULL,               -- Names of the cast members
  `country` varchar(150) NULL,             -- Country where the content was produced
  `date_added` varchar(100) NULL,          -- Date when the content was added to Netflix
  `release_year` BIGINT NULL,              -- Year the content was released
  `rating` varchar(100) NULL,              -- Content rating (e.g., PG, R)
  `duration` varchar(100) NULL,            -- Duration of the content (e.g., '90 min', '1 Season')
  `listed_in` varchar(100) NULL,           -- Categories/genres the content belongs to
  `description` varchar(1000) NULL         -- Brief description of the content
);

-- Load data from a CSV file into the `net_title` table
LOAD DATA LOCAL INFILE 'D:/Projects/MySQL/4- Netflix Movies/netflix_titles.csv'
INTO TABLE net_title
FIELDS TERMINATED BY ","                   -- Fields in the CSV are separated by commas
ENCLOSED BY '"'                            -- Fields are enclosed in double quotes
LINES TERMINATED BY "\n"                   -- Each record ends with a newline
IGNORE 1 ROWS                              -- Skip the header row in the CSV
(@show_id, @type, @title, @director, @cast, @country, @date_added, @release_year, @rating, @duration, @listed_in, @description)
SET
  show_id = NULLIF(@show_id, ''),          -- Set `show_id` to NULL if empty
  type = NULLIF(@type, ''),                -- Set `type` to NULL if empty
  title = NULLIF(@title, ''),              -- Set `title` to NULL if empty
  director = NULLIF(@director, ''),        -- Set `director` to NULL if empty
  cast = NULLIF(@cast, ''),                -- Set `cast` to NULL if empty
  country = NULLIF(@country, ''),          -- Set `country` to NULL if empty
  date_added = NULLIF(@date_added, ''),    -- Set `date_added` to NULL if empty
  release_year = NULLIF(@release_year, ''),-- Set `release_year` to NULL if empty
  rating = NULLIF(@rating, ''),            -- Set `rating` to NULL if empty
  duration = NULLIF(@duration, ''),        -- Set `duration` to NULL if empty
  listed_in = NULLIF(@listed_in, ''),      -- Set `listed_in` to NULL if empty
  description = NULLIF(@description, '');  -- Set `description` to NULL if empty

-- Update `date_added` column to store dates in the correct format
UPDATE net_title
SET date_added = STR_TO_DATE(date_added, "%M %d,%Y");  -- Convert string dates to `Date` format

-- Alter the `net_title` table to change the data type of `date_added` to `Date`
ALTER TABLE net_title
MODIFY COLUMN date_added DATE;             -- Set the column to hold proper date values


-- *******************************************************************************************



-- 1. Count the number of Movies vs TV Shows
-- This query counts and groups the content by its type (Movie or TV Show).
SELECT
    `type`,
    COUNT(`type`) AS count_type
FROM
    net_title
GROUP BY 
    `type`;


-- 2. Find the most common rating for movies and TV Shows
-- This query identifies the most frequent rating for each type of content (Movie or TV Show).
SELECT 
    *
FROM (
    SELECT
        `type`,
        rating,
        COUNT(rating) AS common_rate,
        ROW_NUMBER() OVER (PARTITION BY type ORDER BY COUNT(rating) DESC) AS rnk
    FROM
        net_title
    GROUP BY
        `type`, rating
) AS rank_table
WHERE
    rnk = 1;


-- 3. List all movies released in a specific year (e.g., 2020)
-- This query retrieves all Movie-type content that was released in the specified year (2020).
SELECT 
    *
FROM
    net_title
WHERE
    type = "Movie"
    AND release_year = 2020;


-- 4. Find the top 5 countries with the most content on Netflix
-- This query lists the top 5 countries by the number of content items available, excluding null values.
SELECT
    country,
    COUNT(type) AS num_content
FROM 
    net_title
GROUP BY
    country
HAVING country IS NOT NULL
ORDER BY 2 DESC
LIMIT 5;


-- 5. Identify the longest movie
-- This query finds the longest movie based on the duration column.
SELECT 
    title,
    SUM(SUBSTRING(duration, 1, LENGTH(duration) - 4)) AS movie_len
FROM
    net_title
WHERE
    type = "Movie"
GROUP BY 
    title
ORDER BY 2 DESC
LIMIT 1;


-- 6. Find content added in the last 5 years
-- This query retrieves all content added to Netflix in the past 5 years from the most recent `date_added`.
SELECT
    *
FROM
    net_title
WHERE
    date_added BETWEEN (SELECT DATE_SUB(MAX(date_added), INTERVAL 5 YEAR) FROM net_title) 
                    AND (SELECT MAX(date_added) FROM net_title);


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'
-- This query retrieves all content directed by 'Rajiv Chilaka'.
SELECT
    *
FROM
    net_title
WHERE    
    director LIKE "%Rajiv Chilaka%";


-- 8. List all TV shows with more than 5 seasons
-- This query retrieves all TV shows with a duration indicating more than 5 seasons.
SELECT
    *
FROM
    net_title
WHERE
    type = "TV Show"
    AND SUBSTRING(duration, 1, 2) > 5;


-- 9. Count the number of content items in each category
-- This query counts how many content items belong to each category (listed_in).
SELECT
    listed_in,
    COUNT(show_id)
FROM
    net_title
GROUP BY
    listed_in
ORDER BY 
    2 DESC;


-- 10. Find each year and the average number of content items released in India on Netflix
-- This query calculates the yearly content count and its percentage of all Indian content on Netflix.
SELECT
    YEAR(date_added) AS year,
    COUNT(show_id) AS num_cont,
    ROUND((COUNT(show_id) / (SELECT COUNT(*) FROM net_title WHERE country LIKE "%India%")) * 100, 2) AS avg_per_year
FROM
    net_title
WHERE
    country LIKE "%India%"
GROUP BY 1
ORDER BY 1 DESC;


-- 11. List all movies that are documentaries
-- This query retrieves all movies categorized as documentaries in the 'listed_in' column.
SELECT
    *
FROM
    net_title
WHERE
    listed_in LIKE "%Documentaries%";


-- 12. Find all content without a director
-- This query retrieves all records where the director field is NULL.
SELECT
    *
FROM
    net_title
WHERE
    director IS NULL;


-- 13. Find how many movies actor 'Salman Khan' appeared in during the last 10 years
-- This query counts the number of movies featuring 'Salman Khan' released in the past 10 years.
SELECT
    REGEXP_SUBSTR(cast, "Salman Khan") AS actor,
    COUNT(show_id) AS num_movies
FROM
    net_title
WHERE
    cast LIKE "%Salman Khan%"
    AND release_year BETWEEN (SELECT MAX(release_year) FROM net_title) - 10 
                         AND (SELECT MAX(release_year) FROM net_title)
GROUP BY
    1;



-- 15. Categorize content based on keywords 'kill' and 'violence' in the description
-- This query categorizes content as 'Bad' if keywords like 'kill' or 'violence' appear in the description, 
-- otherwise labels it as 'Good', and counts the number of items in each category.
SELECT
    cate_movie,
    COUNT(cate_movie)
FROM (
    SELECT
        show_id,
        description,
        CASE 
            WHEN description LIKE "%Kill%" THEN "Bad"
            WHEN description LIKE "%Violence%" THEN "Bad" 
            ELSE "Good"
        END AS cate_movie
    FROM
        net_title
) AS cate_table
GROUP BY 
    cate_movie;
