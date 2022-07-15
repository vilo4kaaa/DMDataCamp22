CREATE CLUSTER hash_cluster ( deptno NUMBER(2))
    HASHKEYS 1000
    SIZE 1024
    STORAGE( INITIAL 100K NEXT 50K );

CREATE TABLE dept(
    deptno NUMBER(2) PRIMARY KEY, 
    dname  VARCHAR2( 14 ), 
    loc    VARCHAR2( 13 )
  ) CLUSTER hash_cluster ( deptno ) ;
  
CREATE TABLE emp ( 
    empno NUMBER PRIMARY KEY,
    ename VARCHAR2( 10 ),
    job   VARCHAR2( 9 ),
    mgr   NUMBER,
    hiredate DATE,
    sal    NUMBER,
    comm   NUMBER,
    deptno NUMBER( 2 ) REFERENCES dept( deptno ) 
  ) CLUSTER hash_cluster ( deptno ) ; 
 
INSERT INTO dept( deptno , dname , loc) 
    SELECT deptno , dname , loc 
    FROM scott.dept; 
COMMIT;

INSERT INTO emp ( empno, ename, job, mgr, hiredate, sal, comm, deptno ) 
    SELECT rownum, ename, job, mgr, hiredate, sal, comm, deptno 
    FROM scott.emp ;
COMMIT; 

SELECT * FROM 
    (SELECT dept_blk, emp_blk, CASE WHEN dept_blk <> emp_blk THEN '*' END flag, deptno 
     FROM (SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( emp.rowid ) emp_blk, dept.deptno 
        FROM emp , dept 
        WHERE emp.deptno = dept.deptno) 
    )ORDER BY deptno;
    
DROP TABLE emp;
DROP TABLE  dept;
DROP CLUSTER hash_cluster;    