-- Vérifier si la base de données existe avant de la créer
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TpBdLeMans_SaadToury_2037266')
BEGIN
    CREATE DATABASE TpBdLeMans_SaadToury_2037266;
END
GO

-- Utilisation de la base de données
USE TpBdLeMans_SaadToury_2037266;
GO

-- Schéma principal pour les entités principales
CREATE SCHEMA racing;
GO

-- Schéma pour les entités de référence
CREATE SCHEMA ref;
GO

-- 1️⃣ Table Modele
CREATE TABLE ref.Modele (
    ModeleID INT IDENTITY(1,1) NOT NULL,
    AnneeConception INT NOT NULL,
    VitesseMax DECIMAL(5,2) NOT NULL,
    Transmission NVARCHAR(50) NOT NULL,
    Motorisation NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Modele PRIMARY KEY (ModeleID)
);
GO

-- 2️⃣ Table Voiture
CREATE TABLE racing.Voiture (
    VoitureID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(100) NOT NULL,
    ModeleID INT NOT NULL,
    CONSTRAINT PK_Voiture PRIMARY KEY (VoitureID)
);
GO

-- 3️⃣ Table Conducteur
CREATE TABLE racing.Conducteur (
    ConducteurID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    Prenom NVARCHAR(50) NOT NULL,
    DateNaissance DATE NOT NULL,
    PaysOrigine NVARCHAR(50) NOT NULL,
    NombreVictoires INT NOT NULL,
    CONSTRAINT PK_Conducteur PRIMARY KEY (ConducteurID)
);
GO

-- 4️⃣ Table Ecurie
CREATE TABLE racing.Ecurie (
    EcurieID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(100) NOT NULL,
    DateIntegration DATE NOT NULL,
    PaysOrigine NVARCHAR(50) NOT NULL,
    NombreVictoires INT NOT NULL,
    ConducteurID INT NULL,
    VoitureID INT NULL,
    CONSTRAINT PK_Ecurie PRIMARY KEY (EcurieID)
);
GO

-- 5️⃣ Table Champion
CREATE TABLE racing.Champion (
    ChampionID INT IDENTITY(1,1) NOT NULL,
    Annee INT NOT NULL,
    ModeleVoitureGagnante NVARCHAR(100) NOT NULL,
    ConducteurID INT NOT NULL,
    EcurieID INT NOT NULL,
    CONSTRAINT PK_Champion PRIMARY KEY (ChampionID)
);
GO

-- 6️⃣ Table Circuit
CREATE TABLE ref.Circuit (
    CircuitID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(100) NOT NULL,
    Longueur DECIMAL(6,2) NOT NULL,
    NombreVirages INT NOT NULL,
    CONSTRAINT PK_Circuit PRIMARY KEY (CircuitID)
);
GO

-- 7️⃣ Table Course
CREATE TABLE racing.Course (
    CourseID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(100) NOT NULL,
    Date DATE NOT NULL,
    Pays NVARCHAR(50) NOT NULL,
    CircuitID INT NOT NULL,
    ChampionID INT NOT NULL,
    CONSTRAINT PK_Course PRIMARY KEY (CourseID)
);
GO


--  Ajout des Contraintes CHECK
ALTER TABLE ref.Modele ADD CONSTRAINT CHK_AnneeConception CHECK (AnneeConception BETWEEN 1900 AND YEAR(GETDATE()));
ALTER TABLE ref.Modele ADD CONSTRAINT CHK_VitesseMax CHECK (VitesseMax > 0);
ALTER TABLE racing.Conducteur ADD CONSTRAINT CHK_DateNaissance CHECK (DateNaissance < GETDATE());
ALTER TABLE racing.Conducteur ADD CONSTRAINT CHK_NombreVictoires CHECK (NombreVictoires >= 0);
ALTER TABLE racing.Ecurie ADD CONSTRAINT CHK_NombreVictoiresEcurie CHECK (NombreVictoires >= 0);
ALTER TABLE racing.Champion ADD CONSTRAINT CHK_Annee CHECK (Annee BETWEEN 1900 AND YEAR(GETDATE()));
ALTER TABLE ref.Circuit ADD CONSTRAINT CHK_Longueur CHECK (Longueur > 0);
ALTER TABLE ref.Circuit ADD CONSTRAINT CHK_NombreVirages CHECK (NombreVirages > 0);
ALTER TABLE racing.Course ADD CONSTRAINT CHK_DateCourse CHECK (Date >= '1923-05-26');

--  Ajout des Contraintes DEFAULT
ALTER TABLE racing.Conducteur ADD CONSTRAINT DF_PaysOrigine DEFAULT 'Inconnu' FOR PaysOrigine;
ALTER TABLE racing.Conducteur ADD CONSTRAINT DF_NombreVictoires DEFAULT 0 FOR NombreVictoires;
ALTER TABLE racing.Ecurie ADD CONSTRAINT DF_PaysOrigineEcurie DEFAULT 'Inconnu' FOR PaysOrigine;
ALTER TABLE racing.Ecurie ADD CONSTRAINT DF_NombreVictoiresEcurie DEFAULT 0 FOR NombreVictoires;
ALTER TABLE ref.Modele ADD CONSTRAINT DF_Transmission DEFAULT 'Manuelle' FOR Transmission;

--  Ajout des Clés Étrangères
ALTER TABLE racing.Voiture ADD CONSTRAINT FK_Voiture_Modele FOREIGN KEY (ModeleID) REFERENCES ref.Modele(ModeleID) ON DELETE CASCADE;
ALTER TABLE racing.Ecurie ADD CONSTRAINT FK_Ecurie_Conducteur FOREIGN KEY (ConducteurID) REFERENCES racing.Conducteur(ConducteurID) ON DELETE SET NULL;
ALTER TABLE racing.Ecurie ADD CONSTRAINT FK_Ecurie_Voiture FOREIGN KEY (VoitureID) REFERENCES racing.Voiture(VoitureID) ON DELETE SET NULL;
ALTER TABLE racing.Champion ADD CONSTRAINT FK_Champion_Conducteur FOREIGN KEY (ConducteurID) REFERENCES racing.Conducteur(ConducteurID) ON DELETE CASCADE;
ALTER TABLE racing.Champion ADD CONSTRAINT FK_Champion_Ecurie FOREIGN KEY (EcurieID) REFERENCES racing.Ecurie(EcurieID) ON DELETE CASCADE;
ALTER TABLE racing.Course ADD CONSTRAINT FK_Course_Circuit FOREIGN KEY (CircuitID) REFERENCES ref.Circuit(CircuitID) ON DELETE CASCADE;
ALTER TABLE racing.Course ADD CONSTRAINT FK_Course_Champion FOREIGN KEY (ChampionID) REFERENCES racing.Champion(ChampionID) ON DELETE CASCADE;
