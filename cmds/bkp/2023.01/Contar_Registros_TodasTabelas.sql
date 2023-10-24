-- Exportar o resultado para Excel
set term #;

execute block
returns (
    r1 varchar(100),
    r2 varchar(100)
)
as
    declare variable t1 varchar(100);

begin
    for
-----------------------

select 
    r.RDB$RELATION_NAME
from RDB$RELATIONS r
where 
    r.RDB$SYSTEM_FLAG = 0

-----------------------        
    into :t1 do
    begin
        for execute statement        
        -----------------------

		'select '''
			||trim(:t1)||''', '
			||'count(*) '
		||'from '||trim(:t1)

        -------------------------
        into :r1, :r2 do
        begin
            suspend;
        end
    end
end#

set term ;#