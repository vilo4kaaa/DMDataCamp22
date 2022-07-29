CREATE TABLE range_example( 
    range_key_column date NOT NULL,
    data             varchar2(20) 
)
PARTITION BY RANGE (range_key_column)
 (PARTITION part_1 VALUES LESS THAN
     (to_date('01/01/2014','dd/mm/yyyy')),
PARTITION part_2 VALUES LESS THAN
     (to_date('01/01/2015','dd/mm/yyyy')),
PARTITION part_3 VALUES LESS THAN
     (to_date('01/01/2016','dd/mm/yyyy')),
PARTITION part_4 VALUES LESS THAN
     (to_date('01/01/2017','dd/mm/yyyy'))
)
/
  
insert into range_example(range_key_column, data )
  values
  ( to_date( '15-dec-2013 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );
  
insert into range_example(range_key_column, data )
  values
  ( to_date( '01-jan-2014 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );

insert into range_example(range_key_column, data )
  values
  ( to_date( '01-may-2015 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );
  
insert into range_example(range_key_column, data )
  values
  ( to_date( '07-apr-2016 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );
  
select * from range_example;

select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (part_1);
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (part_2);
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (part_3);
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (part_4);

ALTER TABLE range_example
      ADD PARTITION part_5 VALUES LESS THAN (to_date('01/01/2020','dd/mm/yyyy'));
      
insert into range_example(range_key_column, data )
  values
  ( to_date( '11-jan-2019 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );

select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (part_5);

-----------------

ALTER TABLE RANGE_EXAMPLE DROP PARTITION part_5;
select * from range_example;

-----------------
ALTER TABLE range_example
      ADD PARTITION part_5 VALUES LESS THAN (to_date('01/01/2020','dd/mm/yyyy'));
      
insert into range_example(range_key_column, data )
  values
  ( to_date( '11-jan-2019 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );

select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (part_5);

-----------------

ALTER TABLE range_example 
MERGE PARTITIONS PART_4, PART_5 INTO PARTITION PART_5;
select * from range_example;

select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (part_5);

insert into range_example(range_key_column, data )
  values
  ( to_date( '07-apr-2016 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );
  
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (part_5);

_______________
CREATE TABLESPACE ts_stuff
DATAFILE '/oracle/u02/oradata/VMasyukdb/db_suff.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO; 
 
 
ALTER TABLE range_example
  MOVE PARTITION part_5
   TABLESPACE ts_stuff;

SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;

----------------

ALTER TABLE RANGE_EXAMPLE SPLIT PARTITION part_3 at (TO_DATE('01/06/2015', 'DD/MM/YYYY')) 
      INTO ( PARTITION sp1, PARTITION sp2);
      
insert into range_example(range_key_column, data )
  values
  ( to_date( '03-jun-2015 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );
  
insert into range_example(range_key_column, data )
  values
  ( to_date( '01-may-2015 00:00:00','dd-mon-yyyy hh24:mi:ss' ),'application data...' );
  
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (sp1);
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (sp2);
      

----------------
ALTER TABLE RANGE_EXAMPLE TRUNCATE PARTITION SP2;
select to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') from range_example partition (sp2);
SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;