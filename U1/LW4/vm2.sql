CREATE TABLE t2 AS 
 SELECT TRUNC( rownum / 100 ) id, rpad( rownum, 100 ) t_pad 
   FROM dual 
CONNECT BY rownum < 100000; 

CREATE INDEX t2_idx1 ON t2 
  ( id ); 
  
CREATE TABLE t1 AS 
 SELECT MOD( rownum, 100 ) id, rpad( rownum,100 ) t_pad 
   FROM dual 
CONNECT BY rownum < 100000; 

CREATE INDEX t1_idx1 ON t1 
  ( id ); 
  
EXEC dbms_stats.gather_table_stats( USER,'t1',method_opt=>'FOR ALL COLUMNS SIZE 1',CASCADE=>TRUE );
EXEC dbms_stats.gather_table_stats( USER,'t2',method_opt=>'FOR ALL COLUMNS SIZE 1',CASCADE=>TRUE );

SELECT  t.table_name||'.'||i.index_name idx_name, 
        i.clustering_factor, 
        t.blocks, 
        t.num_rows 
FROM user_indexes i, user_tables t 
WHERE i.table_name = t.table_name 
AND t.table_name  IN( 'T1','T2' );


CREATE UNIQUE INDEX udx_t1 ON t1( t_pad );

EXPLAIN PLAN FOR
SELECT t1.*  FROM t1 where t1.t_pad = '1';
SELECT * FROM TABLE(dbms_xplan.display );

EXPLAIN PLAN FOR
SELECT t2.*  FROM t2 where t2.id = '1';
SELECT * FROM TABLE(dbms_xplan.display );

DROP TABLE t1;
DROP TABLE t2;


CREATE TABLE emp AS 
    SELECT * FROM scott.emp; 

CREATE INDEX idx_emp01 ON emp
    ( empno, ename, job ); 

SELECT BLOCKS FROM user_segments WHERE segment_name = 'EMP';
SELECT COUNT(DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct FROM emp ;

SELECT emp.* FROM emp emp where ename = 'SCOTT';
SELECT /*+INDEX_SS(emp idx_emp01)*/ emp.* FROM emp emp where ename = 'SCOTT';
SELECT /*+FULL(emp) */ emp.* FROM emp emp WHERE ename = 'SCOTT';

DROP TABLE emp;