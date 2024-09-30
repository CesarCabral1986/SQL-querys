
'Mostra o log'
SELECT * 
FROM sys.fn_dblog(NULL, NULL);

'Mostra o tamanho dos arquivos'
USE GLocacao_Cipa_10778;
GO
DBCC SQLPERF(LOGSPACE);

'nome do arquivo'

SELECT 
    name AS [Nome do Arquivo],
    physical_name AS [Localização Física],
    type_desc AS [Tipo de Arquivo],
    database_id,
    DB_NAME(database_id) AS GLocacao_Cipa_10778
FROM sys.master_files
WHERE type_desc = 'LOG'
AND database_id = DB_ID('GLocacao_Cipa_10778');


'aumentar o tamanho'

USE master;
GO
ALTER DATABASE GLocacao_Cipa_10778
MODIFY FILE (
    NAME = GLocacao_log, 
    SIZE = 500MB
);
