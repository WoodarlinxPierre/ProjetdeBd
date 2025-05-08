CREATE DATABASE ConcessionaireMercedes;
GO

USE ConcessionaireMercedes;
GO

-- Schémas
CREATE SCHEMA Configurations;
GO
CREATE SCHEMA Voitures;
GO

-- Création des tables + contraintes de clé primaire

-- TABLE Fonctionnalite
CREATE TABLE Configurations.Fonctionnalite (
    FonctionnaliteID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Fonctionnalite_FonctionnaliteID PRIMARY KEY (FonctionnaliteID)
);

-- TABLE FonctionnaliteVersion
CREATE TABLE Configurations.FonctionnaliteVersion (
    FonctionnaliteVersionID INT IDENTITY(1,1) NOT NULL,
    EstOptionel BIT NOT NULL,
    CONSTRAINT PK_FonctionnaliteVersion_FonctionnaliteVersionID PRIMARY KEY (FonctionnaliteVersionID)
);

-- TABLE Moteur
CREATE TABLE Configurations.Moteur (
    MoteurID INT IDENTITY(1,1) NOT NULL,
    TypeCarburant NVARCHAR(30) NOT NULL,
    NbCylindre INT NOT NULL,
    EstTurbocharger BIT NOT NULL,
    EstSupercharger BIT NOT NULL,
    CONSTRAINT PK_Moteur_MoteurID PRIMARY KEY (MoteurID)
);

-- TABLE Voiture
CREATE TABLE Voitures.Voiture (
    VoitureID INT IDENTITY(1,1) NOT NULL,
    Couleur NVARCHAR(30) NOT NULL,
    Prix DECIMAL(18, 2) NOT NULL,
    Kilometrage INT NOT NULL,
    Disponible BIT NOT NULL,
    CONSTRAINT PK_Voiture_VoitureID PRIMARY KEY (VoitureID)
);

-- TABLE Version
CREATE TABLE Configurations.Version (
    VersionID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(20) NOT NULL,
    NbChevaux INT NOT NULL,
    BoiteVitesse NVARCHAR(20) NOT NULL,
    AnneeLancement Date NOT NULL,
    Couple INT NOT NULL,
    CapReservoir INT NOT NULL,
    CONSTRAINT PK_Version_VersionID PRIMARY KEY (VersionID)
);

-- TABLE Modele
CREATE TABLE Configurations.Modele (
    ModeleID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    TypeCarosserie NVARCHAR(50) NOT NULL,
    AnneeLancement Date NOT NULL,
    CONSTRAINT PK_Modele_ModeleID PRIMARY KEY (ModeleID)
);

-- Ajout des colonnes FK 

-- FonctionnaliteVersion
ALTER TABLE Configurations.FonctionnaliteVersion
ADD FonctionnaliteID INT NOT NULL,
    VersionID INT NOT NULL;
-- Moteur
ALTER TABLE Configurations.Moteur
ADD VersionID INT NOT NULL;

-- Voiture
ALTER TABLE Voitures.Voiture
ADD VersionID INT NOT NULL;

-- Version
ALTER TABLE Configurations.Version
ADD ModeleID INT NOT NULL;



--- Contraintes de clé étrangère

       --FonctionnaliteVersion--
--Fonctionnalite
ALTER TABLE Configurations.FonctionnaliteVersion
ADD CONSTRAINT FK_FonctionnaliteVersion_FonctionnaliteID 
FOREIGN KEY (FonctionnaliteID) REFERENCES Configurations.Fonctionnalite(FonctionnaliteID);
GO 
--Version
ALTER TABLE Configurations.FonctionnaliteVersion
ADD CONSTRAINT FK_FonctionnaliteVersion_VersionID 
FOREIGN KEY (VersionID) REFERENCES Configurations.Version(VersionID);
 GO
         --Moteur--
ALTER TABLE Configurations.Moteur
ADD CONSTRAINT FK_Moteur_VersionID 
FOREIGN KEY (VersionID) REFERENCES Configurations.Version(VersionID);
GO
         --Voiture--
ALTER TABLE Voitures.Voiture
ADD CONSTRAINT FK_Voiture_VersionID 
FOREIGN KEY (VersionID) REFERENCES Configurations.Version(VersionID)
ON DELETE CASCADE;
     GO  
	   --Version--
ALTER TABLE Configurations.Version
ADD CONSTRAINT FK_Version_ModeleID 
FOREIGN KEY (ModeleID) REFERENCES Configurations.Modele(ModeleID);
Go
-- Autres contraintes

-- Fonctionnalite
ALTER TABLE Configurations.Fonctionnalite
ADD CONSTRAINT UQ_Fonctionnalite_Nom UNIQUE (Nom);
GO
-- Voiture
ALTER TABLE Voitures.Voiture
ADD CONSTRAINT CHK_Voiture_Prix 
CHECK (Prix > 0);
GO
--MOTEUR
Alter Table Configurations.Moteur
ADD CONSTRAINT DF_Moteur_EstTurbocharger 
Default 0  For EstTurbocharger;
GO
Alter Table Configurations.Moteur
ADD CONSTRAINT DF_Moteur_EstSupercharger 
Default 0  For EstSupercharger;
GO