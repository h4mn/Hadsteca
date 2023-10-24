--/*
select
    rf.RDB$RELATION_NAME
    ,rf.RDB$FIELD_NAME
from RDB$RELATION_FIELDS rf
where rf.RDB$FIELD_NAME like '%DATA_VCTO_DPVAT%'
--*/
--select * from CADASTRO_VEICULO cv