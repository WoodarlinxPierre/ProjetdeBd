USE ConcessionaireMercedes;
GO

-- Création de la table ImageVoiture avec FILESTREAM et identifiant unique
CREATE TABLE Voitures.ImageVoiture (
    ImageVoitureID INT IDENTITY NOT NULL,
    Identifiant UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL,
    VoitureID INT NULL,
    CONSTRAINT PK_ImageVoiture PRIMARY KEY (ImageVoitureID)
);
GO

-- Contraintes supplémentaires
ALTER TABLE Voitures.ImageVoiture
ADD CONSTRAINT UC_ImageVoiture_Identifiant UNIQUE (Identifiant);
GO

ALTER TABLE Voitures.ImageVoiture
ADD CONSTRAINT DF_ImageVoiture_Identifiant DEFAULT NEWID() FOR Identifiant;
GO

-- Colonne FILESTREAM pour contenir l'image
ALTER TABLE Voitures.ImageVoiture
ADD PhotoContent VARBINARY(MAX) FILESTREAM NULL;
GO

-- Clé étrangère
ALTER TABLE Voitures.ImageVoiture
ADD CONSTRAINT FK_ImageVoiture_VoitureID FOREIGN KEY (VoitureID)
REFERENCES Voitures.Voiture(VoitureID);
GO


INSERT INTO Voitures.ImageVoiture (VoitureID, PhotoContent)
SELECT 1, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\6235923\Downloads\ProjetdeBd\ProjetFinal_6235923\ProjetFinalBD_WoodarlinxPierre\ProjetFinal\ProjetFinal\Images\A35.jpg',
    SINGLE_BLOB
) AS myFile;
GO

INSERT INTO Voitures.ImageVoiture (VoitureID, PhotoContent)
SELECT 2, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\6235923\Downloads\ProjetdeBd\ProjetFinal_6235923\ProjetFinalBD_WoodarlinxPierre\ProjetFinal\ProjetFinal\Images\C63.jfif',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO Voitures.ImageVoiture (VoitureID, PhotoContent)
SELECT 3, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\6235923\Downloads\ProjetdeBd\ProjetFinal_6235923\ProjetFinalBD_WoodarlinxPierre\ProjetFinal\ProjetFinal\Images\G63 gris .jfif',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO Voitures.ImageVoiture (VoitureID, PhotoContent)
SELECT 4, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\6235923\Downloads\ProjetdeBd\ProjetFinal_6235923\ProjetFinalBD_WoodarlinxPierre\ProjetFinal\ProjetFinal\Images\E300 bleu.jpg',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO Voitures.ImageVoiture (VoitureID, PhotoContent)
SELECT 5, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\6235923\Downloads\ProjetdeBd\ProjetFinal_6235923\ProjetFinalBD_WoodarlinxPierre\ProjetFinal\ProjetFinal\Images\S500 noir.jpg',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO Voitures.ImageVoiture (VoitureID, PhotoContent)
SELECT 6, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\6235923\Downloads\ProjetdeBd\ProjetFinal_6235923\ProjetFinalBD_WoodarlinxPierre\ProjetFinal\ProjetFinal\Images\A180 rouge.jpg',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO Voitures.ImageVoiture (VoitureID, PhotoContent)
SELECT 7, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\6235923\Downloads\ProjetdeBd\ProjetFinal_6235923\ProjetFinalBD_WoodarlinxPierre\ProjetFinal\ProjetFinal\Images\B200 gris.jpg',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO Voitures.ImageVoiture (VoitureID, PhotoContent)
SELECT 8, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\6235923\Downloads\ProjetdeBd\ProjetFinal_6235923\ProjetFinalBD_WoodarlinxPierre\ProjetFinal\ProjetFinal\Images\Gla250 blanc.webp',
    SINGLE_BLOB
) AS myFile;
GO
INSERT INTO Voitures.ImageVoiture (VoitureID, PhotoContent)
SELECT 8, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\6235923\Downloads\ProjetdeBd\ProjetFinal_6235923\ProjetFinalBD_WoodarlinxPierre\ProjetFinal\ProjetFinal\Images\Glc300 argent.jpg',
    SINGLE_BLOB
) AS myFile;
GO

