# Netflix Movies Analysis 📊

This project leverages MySQL to analyze the Netflix dataset, aiming to uncover trends, insights, and patterns about Netflix's movie and TV show offerings. The dataset, `netflix_titles.csv`, contains comprehensive information about Netflix's catalog, including title details, ratings, release years, genres, and more.

---

## Table of Contents
1. [About the Project](#about-the-project)
2. [Dataset Description](#dataset-description)
3. [Objectives and Analysis](#objectives-and-analysis)
4. [Key Features](#key-features)
5. [Technologies Used](#technologies-used)
6. [SQL Queries Overview](#SQL-Queries-Overview)
7. [Challenges and Learnings](#Challenges-and-Learnings)
8. [Contact](#Contact)

---

## About the Project

Netflix, one of the leading content streaming platforms globally, boasts a rich and diverse collection of movies and TV shows. This project seeks to explore and analyze Netflix's offerings through SQL queries to generate meaningful insights, such as:
- Content trends by type, region, or director.
- Popular ratings and genres.
- Key actors and their contributions to Netflix's content library.

This project demonstrates the use of MySQL for exploratory data analysis (EDA) and advanced querying techniques.

---

## Dataset Description

The dataset used in this project is a cleaned and structured version of Netflix's public data. Below are the key columns and their descriptions:

| Column Name    | Description                                                                                   |
|----------------|-----------------------------------------------------------------------------------------------|
| `show_id`      | Unique identifier for each show.                                                             |
| `type`         | Content type: Movie or TV Show.                                                              |
| `title`        | Title of the content.                                                                        |
| `director`     | Director(s) of the content.                                                                  |
| `cast`         | Cast members featured in the content.                                                        |
| `country`      | Country of origin for the content.                                                           |
| `date_added`   | Date when the content was added to Netflix.                                                  |
| `release_year` | Year the content was originally released.                                                    |
| `rating`       | Maturity rating of the content (e.g., PG, TV-MA).                                            |
| `duration`     | Length of the content (in minutes for movies or number of seasons for TV shows).             |
| `listed_in`    | Categories/genres the content belongs to.                                                    |
| `description`  | Short synopsis or description of the content.                                                |

### Sample Data

| show_id | type    | title                  | director           | cast                      | country        | date_added | release_year | rating | duration | listed_in                        | description                                                                                         |
|---------|---------|------------------------|--------------------|---------------------------|----------------|------------|--------------|--------|----------|----------------------------------|-----------------------------------------------------------------------------------------------------|
| s1      | Movie   | Dick Johnson Is Dead  | Kirsten Johnson    |                           | United States  | 25-Sep-21  | 2020         | PG-13  | 90 min   | Documentaries                   | As her father nears the end of his life, filmmaker Kirsten Johnson stages his death in comical ways.|
| s2      | TV Show | Blood & Water         |                    | Ama Qamata, Khosi Ngema  | South Africa   | 24-Sep-21  | 2021         | TV-MA  | 2 Seasons | International TV Shows, TV Dramas, TV Mysteries | After crossing paths at a party, a Cape Town teen sets out to uncover her sister’s abduction.        |

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

## Technologies Used

- **MySQL**: For database management and querying.
- **Python (optional)**: For preprocessing the dataset or additional visualization (if needed).
- **GitHub**: For version control and project sharing.

---

## SQL Queries Overview

This project features 14+ SQL queries designed to provide insights into Netflix's content catalog. Below is an overview of the key queries and their objectives:

1. **Content Distribution**:
   - Count the number of Movies vs TV Shows on Netflix.

2. **Rating Trends**:
   - Identify the most common rating for movies and TV shows.

3. **Release Year Insights**:
   - List all movies released in a specific year (e.g., 2020).

4. **Top Content-Producing Countries**:
   - Find the top 5 countries with the most content on Netflix.

5. **Longest Movie Analysis**:
   - Identify the longest movie in Netflix's catalog.

6. **Recent Additions**:
   - Find content added in the last 5 years.

7. **Director and Actor Focus**:
   - List all movies/TV shows by specific directors (e.g., *Rajiv Chilaka*).
   - Analyze the contribution of notable actors (e.g., *Salman Khan*).

8. **Multi-Season TV Shows**:
   - List all TV shows with more than 5 seasons.

9. **Genre and Category Analysis**:
   - Count content items based on genres (`listed_in` field).

10. **Content Categorization**:
    - Categorize titles as "Good" or "Bad" based on the presence of keywords (e.g., "kill," "violence").

---

## Challenges and Learnings

### Challenges:
- Handling missing or null values in columns such as `director` and `cast`.
- Parsing and extracting meaningful insights from unstructured text fields like `duration` and `description`.
- Ensuring accurate data type conversions (e.g., converting `date_added` to a valid date format).

### Learnings:
- Leveraged advanced SQL techniques like **window functions**, **string manipulation**, and **conditional aggregation** to extract insights.
- Gained deeper insights into Netflix's global content strategies and trends.

---
## Contact

If you have any questions or suggestions regarding this project, feel free to reach out:
- **Email**: [bahawanas427@gmail.com](mailto:bahawanas427@gmail.com)
- **LinkedIn**: [Bahaa Wanas](https://www.linkedin.com/in/bahaa-wanas-9797b923a)

---
