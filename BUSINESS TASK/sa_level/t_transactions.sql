alter session set current_schema = SA_THEATER_DATA;

select count(*) from SA_EXT_REF_DATA.SA_T_THEATERS;
select count(*) from SA_T_SHOWINGS;
select count(*) from SA_CURRENCIES_DATA.SA_T_CURRENCY;
select count(*) from SA_PROMOTION_DATA.SA_T_PROMOTIONS;

GRANT SELECT ON SA_T_CURRENCY TO SA_THEATER_DATA;
GRANT SELECT ON SA_T_PROMOTIONS TO SA_THEATER_DATA;
GRANT SELECT ON SA_T_THEATERS TO SA_THEATER_DATA;
GRANT SELECT ON SA_T_MOVIE TO SA_THEATER_DATA;


describe SA_THEATER_DATA.transactions;
drop table transactions;

CREATE TABLE transactions
  AS(
select a.TRANSACTION_DATE, sa_t_showings.showing_id, SA_EXT_REF_DATA.sa_t_theaters.country_code, SA_EXT_REF_DATA.sa_t_theaters.theater_name, 
    SA_EXT_REF_DATA.sa_t_movie.movie_name, a.sold_tickets, SA_T_SHOWINGS.ticket_price AS TICKET_PRICE, SA_T_PROMOTIONS.DISCOUNT AS DISCOUNT, 
    (a.sold_tickets *SA_T_SHOWINGS.ticket_price * (1-SA_T_PROMOTIONS.DISCOUNT)) AS TICKETS_REVENUE, SA_CURRENCIES_DATA.SA_T_CURRENCY.currency_name AS currency FROM(
        select b.* , TRUNC(DBMS_RANDOM.VALUE( 1,101)) as SHOWING, TRUNC(DBMS_RANDOM.VALUE( 1,101)) as SOLD_TICKETS, TRUNC(DBMS_RANDOM.VALUE( 1,101)) as PROMOTION
        FROM
        (SELECT TRUNC(TO_DATE( '09/08/2020', 'DD/MM/YYYY' )+ 
            TRUNC(DBMS_RANDOM.VALUE( 1, (to_date('03/08/2022', 'DD/MM/YYYY') - to_date('09/08/2020', 'DD/MM/YYYY')+1)))) TRANSACTION_DATE, rownum as rn FROM dual
        CONNECT BY level <= 500000
        )b
)a
LEFT JOIN SA_THEATER_DATA.sa_t_showings on SHOWING = sa_t_showings.showing_id
LEFT JOIN SA_EXT_REF_DATA.sa_t_theaters on sa_t_showings.theater_id = SA_EXT_REF_DATA.sa_t_theaters.theater_id
LEFT JOIN SA_EXT_REF_DATA.sa_t_movie on sa_t_showings.movie_id = SA_EXT_REF_DATA.sa_t_movie.movie_id
LEFT JOIN SA_CURRENCIES_DATA.SA_T_CURRENCY ON SA_EXT_REF_DATA.sa_t_theaters.COUNTRY_CODE = SA_T_CURRENCY.CURRENCY_COUNTRY_CODE
LEFT JOIN SA_PROMOTION_DATA.SA_T_PROMOTIONS on PROMOTION = SA_T_PROMOTIONS.PROMOTION_ID);

SELECT * FROM transactions ORDER BY TRANSACTION_DATE;

SELECT COUNT(*) FROM transactions;

SELECT EXTRACT(YEAR FROM TRANSACTION_DATE) as year, COUNT(*) as transactions_per_year
FROM transactions
GROUP BY EXTRACT(YEAR FROM TRANSACTION_DATE);

SELECT EXTRACT(MONTH FROM TRANSACTION_DATE) as month, COUNT(*) as transactions_per_month
FROM transactions
GROUP BY EXTRACT(MONTH FROM TRANSACTION_DATE)
ORDER BY month;


GRANT SELECT ON transactions TO DW_CL;

SELECT * FROM transactions;

