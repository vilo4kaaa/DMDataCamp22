alter session set current_schema = DW_STUFF;

CREATE TABLE interval_example
   ( range_key_column date         NOT NULL, data varchar2(20))
  PARTITION BY RANGE (range_key_column)
  INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))
 ( 
    PARTITION p0 VALUES LESS THAN (to_date('01/01/2010','dd/mm/yyyy')),
    PARTITION p1 VALUES LESS THAN (to_date('01/01/2011','dd/mm/yyyy'))
 ) tablespace TS_STUFF;
 
-- ADD PARTITION
ALTER TABLE interval_example
       ADD PARTITION p2 VALUES LESS THAN (MAXVALUE);
       
-- DROP PARTITION
ALTER TABLE INTERVAL_EXAMPLE DROP PARTITION P0;
SELECT to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') FROM interval_example partition (p0);

-- MERGE PARTITIONS
INSERT INTO INTERVAL_EXAMPLE(range_key_column, data )
  VALUES( to_date( '11-jan-2019 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );
  
INSERT INTO INTERVAL_EXAMPLE(range_key_column, data )
  VALUES( to_date( '11-jan-2021 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );
  
SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;

ALTER TABLE INTERVAL_EXAMPLE
      MERGE PARTITIONS FOR(TO_DATE('10-JAN-2010','dd-MON-yyyy')), FOR(TO_DATE('10-JAN-2011','dd-MON-yyyy'));
      
-- TRUNCATE PARTITION
ALTER TABLE INTERVAL_EXAMPLE TRUNCATE PARTITION SYS_P962;

DROP TABLE INTERVAL_EXAMPLE;