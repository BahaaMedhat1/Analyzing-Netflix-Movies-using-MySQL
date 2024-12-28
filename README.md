# Netflix Movies Analysis 📊

This project leverages MySQL to analyze the Netflix dataset, aiming to uncover trends, insights, and patterns about Netflix's movie and TV show offerings. The dataset, `netflix_titles.csv`, contains comprehensive information about Netflix's catalog, including title details, ratings, release years, genres, and more.

---
## About the Project

Netflix, one of the leading content streaming platforms globally, boasts a rich and diverse collection of movies and TV shows. This project seeks to explore and analyze Netflix's offerings through SQL queries to generate meaningful insights, such as:
- Content trends by type, region, or director.
- Popular ratings and genres.
- Key actors and their contributions to Netflix's content library.

This project demonstrates the use of MySQL for exploratory data analysis (EDA) and advanced querying techniques.

---

## Objectives and Analysis

The main objectives of this project include:

1. **Analyzing Netflix Content**:
   - Count movies vs TV shows.
   - Identify the most common ratings and genres.
   
2. **Understanding Trends**:
   - Determine top content-producing countries.
   - Analyze the frequency of content additions over the years.
   
3. **Exploring Specific Data**:
   - Find movies or TV shows by specific directors or actors.
   - Analyze the longest movies or multi-season TV shows.
   
4. **Categorizing and Filtering**:
   - Categorize content based on themes (e.g., "violence" or "kill").
   - Identify content gaps (e.g., missing director information).

---

## Key Features

- A series of **14+ SQL queries** to analyze, filter, and categorize Netflix data.
- Advanced query techniques like **window functions**, **subqueries**, **string manipulation**, and **conditional filtering**.
- Support for filtering by specific criteria such as directors, actors, or content type.

---

## Database Schema Creation and Data Loading
### 1. Creating Database & Tables
```sql
-- Create a database and table for storing Netflix movies and shows data
CREATE DATABASE netflix_movies;
USE netflix_movies;

-- Create a table to store Netflix content details
CREATE TABLE `net_title` (
  `show_id` varchar(10) NULL,
  `type` varchar(10) NULL,
  `title` varchar(150) NULL,
  `director` varchar(208) NULL,
  `cast` varchar(1000) NULL,
  `country` varchar(150) NULL,
  `date_added` varchar(100) NULL,
  `release_year` BIGINT NULL,
  `rating` varchar(100) NULL,
  `duration` varchar(100) NULL,
  `listed_in` varchar(100) NULL,
  `description` varchar(1000) NULL
);
```
### 2. Loading Data into Created Tables
```sql
-- Load data from a CSV file into the `net_title` table
LOAD DATA LOCAL INFILE 'D:/Projects/MySQL/4- Netflix Movies/netflix_titles.csv'
INTO TABLE net_title
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(@show_id, @type, @title, @director, @cast, @country, @date_added, @release_year, @rating, @duration, @listed_in, @description)
SET
  show_id = NULLIF(@show_id, ''),
  type = NULLIF(@type, ''),
  title = NULLIF(@title, ''),
  director = NULLIF(@director, ''),
  cast = NULLIF(@cast, ''),
  country = NULLIF(@country, ''),
  date_added = NULLIF(@date_added, ''),
  release_year = NULLIF(@release_year, ''),
  rating = NULLIF(@rating, ''),
  duration = NULLIF(@duration, ''),
  listed_in = NULLIF(@listed_in, ''),
  description = NULLIF(@description, '');

-- Update the `date_added` column to the correct date format
UPDATE net_title
SET date_added = STR_TO_DATE(date_added, "%M %d,%Y");

-- Change the `date_added` column type to `DATE`
ALTER TABLE net_title
MODIFY COLUMN date_added DATE;
```

### Some Advanced SQL Queries
### 1. Categorize content based on keywords 'kill' and 'violence' in the description
```sql
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
-- This query categorizes content as 'Bad' if keywords like 'kill' or 'violence' appear in the description, otherwise labels it as 'Good', and counts the number of items in each category.
```

### 2. Find how many movies actor 'Salman Khan' appeared in during the last 10 years
```sql
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
-- This query counts the number of movies featuring 'Salman Khan' released in the past 10 years.
```

### 3. Find each year and the average number of content items released in India on Netflix
```sql
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
-- This query calculates the yearly content count and its percentage of all Indian content on Netflix.
```
### 4. Find the most common rating for movies and TV Shows
```sql
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
-- This query lists the top 5 countries by the number of content items available, excluding null values.
```

### 5. Find content added in the last 5 years
```sql
SELECT
    *
FROM
    net_title
WHERE
    date_added BETWEEN (SELECT DATE_SUB(MAX(date_added), INTERVAL 5 YEAR) FROM net_title) 
                    AND (SELECT MAX(date_added) FROM net_title);
-- This query retrieves all content added to Netflix in the past 5 years from the most recent `date_added`.
```

### 6. Identify the longest movie
```sql
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
-- This query finds the longest movie based on the duration column.
```

--- 

## Challenges and Learnings

### Challenges:
- Handling missing or null values in columns such as `director` and `cast`.
- Parsing and extracting meaningful insights from unstructured text fields like `duration` and `description`.
- Ensuring accurate data type conversions (e.g., converting `date_added` to a valid date format).
---

## Technologies Used

- **MySQL**: For database management and querying.
- **Python (optional)**: For preprocessing the dataset or additional visualization (if needed).
- **GitHub**: For version control and project sharing.

---

## Contact

If you have any questions or suggestions regarding this project, feel free to reach out:
- **Email**: [bahawanas427@gmail.com](mailto:bahawanas427@gmail.com)
- **LinkedIn**: [Bahaa Wanas](https://www.linkedin.com/in/bahaa-wanas-9797b923a)

---
