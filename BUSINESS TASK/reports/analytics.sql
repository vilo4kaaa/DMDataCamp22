SELECT DISTINCT movie_level1, movie_name,movie_duration, FIRST_VALUE(movie_duration) 
        OVER (PARTITION BY movie_level1 ORDER BY movie_duration ASC
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        AS shortest_movie_in_category
FROM dim_movie
ORDER BY movie_level1, movie_name;

SELECT DISTINCT theater_id, showing_id, ticket_price, LAST_VALUE(ticket_price) 
        OVER (PARTITION BY theater_id ORDER BY ticket_price DESC
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        AS cheapest_tickets
FROM dim_showing
ORDER BY theater_id, showing_id;



SELECT movie_name, movie_level1, rank() OVER(ORDER BY movie_level1 ASC) AS movie_level1_rank
FROM dim_movie;

SELECT movie_name, movie_level1, DENSE_RANK() OVER(ORDER BY movie_level1 ASC) AS movie_level1_rank
FROM dim_movie;

SELECT movie_name, movie_level1, ROW_NUMBER() OVER(ORDER BY movie_level1 ASC) AS movie_num
FROM dim_movie;

        
SELECT * FROM 
        (SELECT EXTRACT(YEAR FROM TRANSACTION_DATE)AS month,  SUM(sold_tickets) as total_sold
         FROM fct_attendance
            GROUP BY EXTRACT(YEAR FROM TRANSACTION_DATE), country_code)
ORDER BY year, country_code;
 
SELECT MAX(total_sold)
 FROM (SELECT EXTRACT(YEAR FROM TRANSACTION_DATE)AS year, country_code, SUM(sold_tickets) as total_sold
        FROM fct_attendance
        GROUP BY EXTRACT(YEAR FROM TRANSACTION_DATE), country_code); 
        
SELECT ROUND(AVG(movie_duration),3) AS average_movie_duration
FROM dim_movie;

SELECT MIN (ticket_price) AS min_ticket_price
FROM dim_showing
WHERE THEATER_ID = 13 AND MOVIE_ID = 20;

SELECT MIN (ticket_price) AS min_ticket_price
FROM dim_showing
WHERE THEATER_ID = 13 AND MOVIE_ID = 15;