SET TERM #;

EXECUTE BLOCK
RETURNS (
    MSG      VARCHAR(50)
)
AS
    DECLARE VARIABLE EXISTE INT = 0;
    DECLARE VARIABLE CLIEN VARCHAR(20) = 'VW_CLIENTE';
    DECLARE VARIABLE FORNE VARCHAR(20) = 'VW_FORNECEDOR';
    DECLARE VARIABLE TRANS VARCHAR(20) = 'VW_TRANSPORTADORA';
    DECLARE VARIABLE PRODU VARCHAR(20) = 'VW_PRODUTO';
    DECLARE VARIABLE ESTOQ VARCHAR(20) = 'VW_ESTOQUE';
BEGIN
    MSG = 'VIEWS VAZIAS CRIADAS';
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = :CLIEN)) THEN
        EXECUTE STATEMENT 'CREATE VIEW ' || :CLIEN || ' (RAZAO_SOCIAL) AS SELECT '''' RAZAO_SOCIAL FROM RDB$DATABASE;';
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = :FORNE)) THEN
        EXECUTE STATEMENT 'CREATE VIEW ' || :FORNE || ' (RAZAO_SOCIAL) AS SELECT '''' RAZAO_SOCIAL FROM RDB$DATABASE;';
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = :TRANS)) THEN
        EXECUTE STATEMENT 'CREATE VIEW ' || :TRANS || ' (RAZAO_SOCIAL) AS SELECT '''' RAZAO_SOCIAL FROM RDB$DATABASE;';
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = :PRODU)) THEN
        EXECUTE STATEMENT 'CREATE VIEW ' || :PRODU || ' (DESCRICAO) AS SELECT '''' RAZAO_SOCIAL FROM RDB$DATABASE;';
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = :ESTOQ)) THEN
        EXECUTE STATEMENT 'CREATE VIEW ' || :ESTOQ || ' (ESTOQUE_ATUAL) AS SELECT 0 ESTOQUE_ATUAL FROM RDB$DATABASE;';

    SUSPEND;
END#

SET TERM ;#