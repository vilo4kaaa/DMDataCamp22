-- Nested Loops Join
SELECT /*+ ORDERED USE_NL(d) */ empno, ename, dname, loc FROM scott.emp e, scott.dept d
WHERE e.deptno = d.deptno;

-- Sort-Merge Join
SELECT /*+  USE_MERGE(e,d) */ empno, ename, dname, loc FROM scott.emp e, scott.dept d
WHERE e.deptno = d.deptno;

-- Hash Join
SELECT /*+  USE_HASH(d,e) */ empno, ename, dname, loc FROM scott.emp e, scott.dept d
WHERE e.deptno = d.deptno;

-- Cartesian Join
SELECT empno, ename, dname, loc FROM scott.dept, scott.emp;

-- Left Outer Join
SELECT * FROM scott.emp e LEFT OUTER JOIN scott.dept d
ON e.deptno = d.deptno; 

-- Right Outer Join
SELECT * FROM scott.emp e RIGHT OUTER JOIN scott.dept d
ON e.deptno = d.deptno; 

-- Full Outer Join
SELECT * FROM scott.emp e FULL OUTER JOIN scott.dept d
ON e.deptno = d.deptno; 

-- Semi-join
SELECT /* using in */ deptno, dname FROM scott.dept d
WHERE deptno IN (select deptno from scott.emp e);

SELECT /* inner join */ d.deptno, dname
FROM scott.dept d, scott.emp e
WHERE d.deptno = e.deptno;

-- Anti-join
SET AUTOTRACE ON
SELECT /* using in */ deptno, dname FROM scott.dept d
WHERE deptno NOT IN (select deptno from scott.emp e);

