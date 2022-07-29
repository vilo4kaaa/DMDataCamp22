CREATE TABLE HASH_EXAMPLE
    ( hash_key_column date,data varchar2(20))
PARTITION BY HASH (hash_key_column)
    ( partition part_1 tablespace ts_references_data_01,
    partition part_2 tablespace TS_STUFF
    )
/

INSERT INTO HASH_EXAMPLE
(hash_key_column, data)
    VALUES(to_date('25-06-2014'),'application data ...');

INSERT INTO HASH_EXAMPLE
(hash_key_column, data)
    VALUES(to_date('27-02-2015'),'application data ...');
    
-- ADD PARTITION
ALTER TABLE HASH_EXAMPLE
    ADD PARTITION part_3 tablespace ts_references_ext_data_01;
    
SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;

-- COALESCE PARTITION
ALTER TABLE HASH_EXAMPLE COALESCE PARTITION;

-- MOVE PARTITION
ALTER TABLE HASH_EXAMPLE MOVE PARTITION part_1 TABLESPACE ts_stuff;

-- TRUNCATE PARTITION
ALTER TABLE HASH_EXAMPLE TRUNCATE PARTITION part_2;

DROP TABLE HASH_EXAMPLE;