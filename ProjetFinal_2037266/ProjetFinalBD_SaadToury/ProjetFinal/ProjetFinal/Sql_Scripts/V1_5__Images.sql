CREATE TABLE racing.Photo  (
    PhotoID      INT IDENTITY NOT NULL,
    Identifiant    UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL,
    ConducteurId         INT NULL,
    CONSTRAINT PK_Photo_PhotoID PRIMARY KEY (PhotoID)
);
GO

ALTER TABLE racing.Photo
ADD CONSTRAINT UC_Photo_Identifiant UNIQUE (Identifiant);
GO

ALTER TABLE racing.Photo
ADD CONSTRAINT DF_Photo_Identifiant DEFAULT NEWID() FOR Identifiant;
GO

ALTER TABLE racing.Photo
ADD PhotoContent VARBINARY(MAX) FILESTREAM NULL;
GO

ALTER TABLE racing.Photo
ADD CONSTRAINT FK_Photo_ConducteurID FOREIGN KEY (ConducteurId)
    REFERENCES racing.Conducteur(ConducteurId);
GO

INSERT INTO racing.Photo (ConducteurId, PhotoContent)
SELECT 1, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2037266\Desktop\ProjetFinalBD_SaadToury\ProjetFinal\ProjetFinal\Images\Kristensen.jfif',
    SINGLE_BLOB
) AS myFile;
GO

INSERT INTO racing.Photo (ConducteurId, PhotoContent)
SELECT 2, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2037266\Desktop\ProjetFinalBD_SaadToury\ProjetFinal\ProjetFinal\Images\Ickx Jacky.jfif',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO racing.Photo (ConducteurId, PhotoContent)
SELECT 3, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2037266\Desktop\ProjetFinalBD_SaadToury\ProjetFinal\ProjetFinal\Images\Foyt.jfif',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO racing.Photo (ConducteurId, PhotoContent)
SELECT 4, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2037266\Desktop\ProjetFinalBD_SaadToury\ProjetFinal\ProjetFinal\Images\negrao_andre.webp',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO racing.Photo (ConducteurId, PhotoContent)
SELECT 5, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2037266\Desktop\ProjetFinalBD_SaadToury\ProjetFinal\ProjetFinal\Images\Dalmas.jfif',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO racing.Photo (ConducteurId, PhotoContent)
SELECT 6, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2037266\Desktop\ProjetFinalBD_SaadToury\ProjetFinal\ProjetFinal\Images\Dindo.jfif',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO racing.Photo (ConducteurId, PhotoContent)
SELECT 7, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2037266\Desktop\ProjetFinalBD_SaadToury\ProjetFinal\ProjetFinal\Images\Pirro.jpg',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO racing.Photo (ConducteurId, PhotoContent)
SELECT 8, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2037266\Desktop\ProjetFinalBD_SaadToury\ProjetFinal\ProjetFinal\Images\Biela.jpg',
    SINGLE_BLOB
) AS myFile;
GO
