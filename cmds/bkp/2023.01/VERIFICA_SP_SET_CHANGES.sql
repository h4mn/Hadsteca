SET TERM #;

EXECUTE BLOCK
RETURNS (
	SP_1 VARCHAR(80),
	SP_2 VARCHAR(80),
	SP_3 VARCHAR(80)
	
)
AS
	DECLARE VARIABLE ALTER_SP_CHANGE_TABLET_EXECUTE VARCHAR(80);
	DECLARE VARIABLE ALTER_SP_SET_CHANGE_TABLET VARCHAR(80);
	DECLARE VARIABLE ALTER_SP_SET_CHANGE VARCHAR(80);
BEGIN
	SP_1 = '';
	SP_2 = '';
	SP_3 = '';
	/* SP_CHANGE_TABLET_EXECUTE */
	SELECT FIRST 1 a.RDB$PROCEDURE_NAME FROM RDB$PROCEDURES a WHERE a.RDB$PROCEDURE_NAME = 'SP_SET_CHANGE' INTO :ALTER_SP_SET_CHANGE;
	IF (:ALTER_SP_SET_CHANGE = 'SP_CHANGE_TABLET_EXECUTE') THEN BEGIN
        SP_1 = 'SP_CHANGE_TABLET_EXECUTE';
	END
	/* SP_SET_CHANGE_TABLET */
	SELECT FIRST 1 a.RDB$PROCEDURE_NAME FROM RDB$PROCEDURES a WHERE a.RDB$PROCEDURE_NAME = 'SP_SET_CHANGE' INTO :ALTER_SP_SET_CHANGE;
	IF (:ALTER_SP_SET_CHANGE = 'SP_SET_CHANGE_TABLET') THEN BEGIN
        SP_2 = 'SP_SET_CHANGE_TABLET';
	END
	/* SP_SET_CHANGE */
	SELECT FIRST 1 a.RDB$PROCEDURE_NAME FROM RDB$PROCEDURES a WHERE a.RDB$PROCEDURE_NAME = 'SP_SET_CHANGE' INTO :ALTER_SP_SET_CHANGE;
	IF (:ALTER_SP_SET_CHANGE = 'SP_SET_CHANGE') THEN BEGIN
        SP_3 = 'SP_SET_CHANGE';
	END

	SUSPEND;
END#

SET TERM ;#