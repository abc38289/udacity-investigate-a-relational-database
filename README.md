# Udacity-Programming for Data Science with Python
# Project: Investigate a Relational Database - Sakila DVD Rental database

### Date created

Jerry Liu created this project on January 3, 2024

## Project Overview

I will use SQL to explore a database related to movie rentals in this project. I will write SQL code to run SQL queries, answer exciting questions about the database, and build visualizations to showcase the output of your queries.

## Dataset Description
**Selected dataset**: [Sakila DVD Rental database](http://www.postgresqltutorial.com/postgresql-sample-database/)

The Sakila Database holds information about a company that rents movie DVDs. For this project, I will query the database to gain an understanding of the customer base, such as what the patterns in movie watching are across different customer groups, how they compare on payment earnings, and how the stores compare in their performance. To assist in the queries ahead, the schema for the DVD Rental database is provided below.

![alt text](https://video.udacity-data.com/topher/2018/September/5ba95d23_dvd-rental-erd-2/dvd-rental-erd-2.png "schema for the DVD Rental database")


## What Software Do I Need??

- PostgreSQL

## Question(s) for Analysis

1. What are the total rental counts in each family-friendly category?
2. How does the length of rental duration of family-friendly movies compare to the duration?
3. How did the two stores compare in their count of rental orders during every month for all the years?
4. According to our top 10 paying customers, who spent the most monthly? 
5. How does the length of rental duration of  family-friendly movies compares to the duration?
6. According to our top 10 paying customers, who spent the most monthly? 


## Summary of Main Findings:

1. Genre Rental Counts:

- Animation has the highest rental count in the family-friendly category, followed by Family.
- Children, Comedy, and Classics show no significant difference in rental counts.

2. Top-Performing Categories by Quartile:
- Quartile 1: Animation
- Quartile 2: Children
- Quartile 3: Family
- Quartile 4: Animation & Family

3. Store Comparison:
- Store 2 had the highest rental count in July.
- Monthly rental patterns are similar between the two stores.

4. Monthly Performance:
- April has the highest rental performance consistently each month.
- Eleanor Hunt has been the top-spending customer for two consecutive months.

5. Top-Performing Categories by Quartile (Alternative Analysis):
- Quartile 1: Animation
- Quartile 2: Children
- Quartile 3: Family
- Quartile 4: Animation & Family

6. Reiteration of April's Performance:
- April stands out as the best-performing month consistently.
- Eleanor Hunt continues to be the top-spending customer for two consecutive months.

