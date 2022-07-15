SELECT DISTINCT BYTES/BLOCKS FROM user_segments;

CREATE TABLE t 
  ( a INT,    
    b VARCHAR2(3500) DEFAULT RPAD('*',3500,'*'),
    c VARCHAR2(4000) DEFAULT RPAD('*',4000,'*'),
    d VARCHAR2(4000) DEFAULT RPAD('*',4000,'*')
    );
    
INSERT INTO t (a) VALUES ( 1); 
INSERT INTO t (a) VALUES ( 2); 
INSERT INTO t (a) VALUES ( 3); 
COMMIT; 

DELETE FROM t WHERE a = 2 ; 
COMMIT; 
INSERT INTO t (a) VALUES ( 4); 
COMMIT; 

SELECT a FROM T;

SELECT dbms_rowid.rowid_block_number( t.rowid ) t From t;

DROP TABLE t;