CREATE FUNCTION dbo.fnConvertUtf8Ansi
(
    @Source VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @Value SMALLINT = 160,
            @Utf8 CHAR(2),
            @Ansi CHAR(1)

    IF @Source NOT LIKE '%[ÂÃ]%'
        RETURN  @Source

    WHILE @Value <= 255
        BEGIN
            SELECT  @Utf8 = CASE
                                WHEN @Value BETWEEN 160 AND 191 THEN CHAR(194) + CHAR(@Value)
                                WHEN @Value BETWEEN 192 AND 255 THEN CHAR(195) + CHAR(@Value - 64)
                                ELSE NULL
                            END,
                    @Ansi = CHAR(@Value)

            WHILE CHARINDEX(@Source, @Utf8) > 0
                SET    @Source = REPLACE(@Source, @Utf8, @Ansi)

            SET    @Value += 1
        END

    RETURN  @Source
END