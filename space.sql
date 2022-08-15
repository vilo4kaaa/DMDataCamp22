-- space by tablespaces
SELECT df.tablespace_name "Tablespace",
  totalusedspace "Used MB",
  (df.totalspace - tu.totalusedspace) "Free MB",
  df.totalspace "Total MB",
  ROUND(100 * ( (df.totalspace - tu.totalusedspace)/ df.totalspace)) "% Free"
FROM
  (SELECT tablespace_name,
    ROUND(SUM(bytes) / 1048576) TotalSpace
  FROM dba_data_files
  GROUP BY tablespace_name
  ) df,
  (SELECT ROUND(SUM(bytes)/(1024*1024)) totalusedspace,
    tablespace_name
  FROM dba_segments
  GROUP BY tablespace_name
  ) tu
WHERE df.tablespace_name = tu.tablespace_name;


-- space by datafiles
select df.tablespace_name, df.file_name, round(df.bytes/1024/1024) totalSizeMB, nvl(round(usedBytes/1024/1024), 0) usedMB, 
nvl(round(freeBytes/1024/1024), 0) freeMB, nvl(round(freeBytes/df.bytes * 100), 0) freePerc, df.autoextensible
from dba_data_files df
    left join (
        select file_id, sum(bytes) usedBytes
        from dba_extents
        group by file_id
    ) ext on df.file_id = ext.file_id
    left join (
        select file_id, sum(bytes) freeBytes
        from dba_free_space
        group by file_id
    ) free on df.file_id = free.file_id
order by df.tablespace_name, df.file_name;

-- space by all db
SELECT SUM (bytes) / 1024 / 1024 / 1024 AS GB FROM dba_data_files;

-- space by data
SELECT SUM (bytes)/1024/1024/1024 AS GB FROM dba_segments;

purge recyclebin;

