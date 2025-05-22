-- Vérifier si la base de données existe avant de la créer
-- Création de la base si elle n'existe pas déjà
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ConcessionaireMercedes')
BEGIN
    CREATE DATABASE ConcessionaireMercedes;
END
GO

-- Configuration de FileStream
EXEC sp_configure filestream_access_level, 2
RECONFIGURE
GO

-- Ajout du FILEGROUP FILESTREAM
ALTER DATABASE ConcessionaireMercedes
ADD FILEGROUP FG_Images_6235923 CONTAINS FILESTREAM;
GO

-- Ajout du fichier physique pour le FILESTREAM
ALTER DATABASE ConcessionaireMercedes
ADD FILE (
    NAME = FG_Images_6235923,
    FILENAME = 'C:\EspaceLabo\FG_Images_6235923'
)
TO FILEGROUP FG_Images_6235923;
GO
