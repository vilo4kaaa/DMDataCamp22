alter session set current_schema = SA_EXT_REF_DATA;

alter session set current_schema = SA_CURRENCIES_DATA;
GRANT SELECT ON SA_T_CURRENCY  TO SA_EXT_REF_DATA;
alter session set current_schema = SA_EXT_REF_DATA;
select * from SA_CURRENCIES_DATA.SA_T_CURRENCY;

drop table transactions;
CREATE TABLE transactions
  AS(

select a.TRANSACTION_DATE, sa_t_showings.showing_type, sa_t_theaters.country_code, sa_t_theaters.theater_name, sa_t_movie.movie_name, a.sold_tickets, (a.sold_tickets *SA_T_SHOWINGS.ticket_price) AS TICKETS_REVENUE, SA_T_CURRENCY.currency_name AS currency from(
select b.* , TRUNC(DBMS_RANDOM.VALUE( 1,101)) as SHOWING, TRUNC(DBMS_RANDOM.VALUE( 1,101)) as SOLD_TICKETS
FROM
    (SELECT TRUNC(TO_DATE( '09/08/2020', 'DD/MM/YYYY' )+ TRUNC(DBMS_RANDOM.VALUE( 1, (to_date('03/08/2022', 'DD/MM/YYYY') - to_date('09/08/2020', 'DD/MM/YYYY')+1)))) TRANSACTION_DATE, rownum as rn FROM dual
     CONNECT BY level <= 500000
  )b
)a
LEFT JOIN SA_THEATER_DATA.sa_t_showings on SHOWING = sa_t_showings.showing_id
LEFT JOIN sa_t_theaters on sa_t_showings.theater_id = sa_t_theaters.theater_id
LEFT JOIN sa_t_movie on sa_t_showings.movie_id = sa_t_movie.movie_id
LEFT JOIN SA_CURRENCIES_DATA.SA_T_CURRENCY ON sa_t_theaters.COUNTRY_CODE = SA_T_CURRENCY.CURRENCY_COUNTRY_CODE);

SELECT * FROM transactions ORDER BY TRANSACTION_DATE;

SELECT COUNT(*) FROM transactions;

SELECT EXTRACT(YEAR FROM TRANSACTION_DATE) as year, COUNT(*) as transactions_per_year
FROM transactions
GROUP BY EXTRACT(YEAR FROM TRANSACTION_DATE);


