alter session set current_schema = SA_THEATER_DATA;

SELECT transaction_date, country_code, COUNT(*) AS transactions, SUM(TICKETS_REVENUE) AS revenue, currency
FROM transactions
GROUP BY CUBE(transaction_date, country_code, currency)
HAVING transaction_date IS NOT NULL AND country_code IS NOT NULL AND currency IS NOT NULL
ORDER BY transaction_date, country_code, revenue DESC;

SELECT transaction_date, movie_name, COUNT(*) AS movie_showing, SUM(SOLD_TICKETS) AS tickets
FROM transactions
GROUP BY CUBE(transaction_date, movie_name)
HAVING transaction_date IS NOT NULL AND movie_name IS NOT NULL 
ORDER BY transaction_date, tickets DESC;

SELECT transaction_date, country_code, theater_name, COUNT(*) AS showings, SUM(SOLD_TICKETS) AS tickets
FROM transactions
GROUP BY CUBE(transaction_date, country_code, theater_name)
HAVING transaction_date IS NOT NULL AND country_code IS NOT NULL AND theater_name IS NOT NULL 
ORDER BY transaction_date, tickets DESC;


       