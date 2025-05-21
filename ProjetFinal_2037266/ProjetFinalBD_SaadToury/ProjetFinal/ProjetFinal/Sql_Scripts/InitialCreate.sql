-- Vérifier si la base de données existe avant de la créer
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ProjetFinalBdLeMans_2037266')
BEGIN
    CREATE DATABASE ProjetFinalBdLeMans_2037266;
END
GO

--Configuration de FileStream
EXEC sp_configure filestream_access_level, 2 RECONFIGURE

ALTER DATABASE ProjetFinalBdLeMans_2037266
ADD FILEGROUP FG_Images_2037266 CONTAINS FILESTREAM;
GO
ALTER DATABASE ProjetFinalBdLeMans_2037266
ADD FILE(
	NAME = FG_Images_2037266,
	FILENAME = 'C:\EspaceLabo\FG_Image_2037266'
)
TO FILEGROUP FG_Images_2037266
GO
