ALTER USER u_dw_references quota unlimited on TS_REFERENCES_DATA_01;

--Initial rows
INSERT INTO t_lng_scopes ( lng_scope_id
                         , lng_scope_code )
     VALUES ( 1
            , 'I' );

INSERT INTO t_lng_scopes ( lng_scope_id
                         , lng_scope_code )
     VALUES ( 2
            , 'M' );

INSERT INTO t_lng_scopes  ( lng_scope_id
                         , lng_scope_code )
     VALUES ( 3
            , 'S' );

COMMIT;    
