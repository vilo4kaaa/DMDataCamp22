alter session set current_schema = SA_THEATER_DATA;

SELECT TRUNC(transaction_date, 'MM') AS month, country_code, DECODE(GROUPING(theater_name), 1, 'All theaters', theater_name) AS theater_name,
       COUNT(*) AS showings, SUM(tickets_revenue) AS revenue, currency
FROM transactions
GROUP BY TRUNC(transaction_date, 'MM'), GROUPING SETS(
    (country_code, theater_name, currency),
    (country_code, currency),
    (TRUNC(transaction_date, 'MM')))
ORDER BY month, country_code, SUM(tickets_revenue) DESC;

SELECT TRUNC(TRANSACTION_DATE, 'MM') as month, country_code, DECODE(GROUPING(theater_name), 1, 'All theaters', theater_name) AS theater_name, 
    COUNT(*) AS transactions, SUM(SOLD_TICKETS) AS tickets
FROM transactions
GROUP BY TRUNC(transaction_date, 'MM'), GROUPING SETS(
    (country_code, theater_name),
    (country_code),
    (TRUNC(TRANSACTION_DATE, 'MM')))
ORDER BY month, country_code, SUM(SOLD_TICKETS) DESC;

SELECT TRUNC(transaction_date, 'MM') AS month, DECODE(GROUPING(movie_name), 1, 'All movies', movie_name) AS movie_name, 
    COUNT(*) AS movie_showing, SUM(SOLD_TICKETS) AS tickets
FROM transactions

GROUP BY GROUPING SETS(
    (TRUNC(transaction_date, 'MM'), movie_name),
    (TRUNC(transaction_date, 'MM')))
ORDER BY month, SUM(SOLD_TICKETS) DESC;




