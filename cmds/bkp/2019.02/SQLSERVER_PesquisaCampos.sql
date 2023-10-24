SELECT
	t.name AS TABELA,
	c.name AS CAMPO
FROM sys.all_columns c
INNER JOIN sys.all_objects t ON t.object_id = c.object_id AND t.type = 'U'
WHERE c.name LIKE '%estoque%'
ORDER BY 1
--SELECT * FROM sys.all_objects t WHERE t.name LIKE 'Mercadoria'
--SELECT * FROM sys.all_objects t WHERE t.type = 'U'