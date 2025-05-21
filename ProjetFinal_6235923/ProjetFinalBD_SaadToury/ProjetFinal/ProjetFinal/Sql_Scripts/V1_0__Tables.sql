-- Utilisation de la base de données
USE ConcessionaireMercedes;
GO

-- TABLES

CREATE TABLE Configuration.Fonctionnalite (
    FonctionnaliteID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Fonctionnalite PRIMARY KEY (FonctionnaliteID),
    CONSTRAINT UQ_Fonctionnalite_Nom UNIQUE (Nom)
);

CREATE TABLE Configuration.Modele (
    ModeleID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    TypeCarosserie NVARCHAR(50) NOT NULL,
    AnneeLancement DATE NOT NULL,
    CONSTRAINT PK_Modele PRIMARY KEY (ModeleID)
);

CREATE TABLE Configuration.Version (
    VersionID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(20) NOT NULL,
    NbChevaux INT NOT NULL,
    BoiteVitesse NVARCHAR(20) NOT NULL,
    AnneeLancement DATE NOT NULL,
    Couple INT NOT NULL,
    CapReservoir INT NOT NULL,
    ModeleID INT NOT NULL,
    CONSTRAINT PK_Version PRIMARY KEY (VersionID),
    CONSTRAINT FK_Version_Modele FOREIGN KEY (ModeleID) REFERENCES Configuration.Modele(ModeleID)
);

CREATE TABLE Configuration.FonctionnaliteVersion (
    FonctionnaliteVersionID INT IDENTITY(1,1) NOT NULL,
    EstOptionel BIT NOT NULL,
    FonctionnaliteID INT NOT NULL,
    VersionID INT NOT NULL,
    CONSTRAINT PK_FonctionnaliteVersion PRIMARY KEY (FonctionnaliteVersionID),
    CONSTRAINT FK_FonctionnaliteVersion_Fonctionnalite FOREIGN KEY (FonctionnaliteID) REFERENCES Configuration.Fonctionnalite(FonctionnaliteID),
    CONSTRAINT FK_FonctionnaliteVersion_Version FOREIGN KEY (VersionID) REFERENCES Configuration.Version(VersionID)
);

CREATE TABLE Configuration.Moteur (
    MoteurID INT IDENTITY(1,1) NOT NULL,
    TypeCarburant NVARCHAR(30) NOT NULL,
    NbCylindre INT NOT NULL,
    EstTurbocharger BIT NOT NULL DEFAULT 0,
    EstSupercharger BIT NOT NULL DEFAULT 0,
    VersionID INT NOT NULL,
    CONSTRAINT PK_Moteur PRIMARY KEY (MoteurID),
    CONSTRAINT FK_Moteur_Version FOREIGN KEY (VersionID) REFERENCES Configuration.Version(VersionID)
);

CREATE TABLE Voitures.Voiture (
    VoitureID INT IDENTITY(1,1) NOT NULL,
    Couleur NVARCHAR(30) NOT NULL,
    Prix DECIMAL(18, 2) NOT NULL CHECK (Prix > 0),
    Kilometrage INT NOT NULL,
    Disponible BIT NOT NULL,
    VersionID INT NOT NULL,
    CONSTRAINT PK_Voiture PRIMARY KEY (VoitureID),
    CONSTRAINT FK_Voiture_Version FOREIGN KEY (VersionID) REFERENCES Configuration.Version(VersionID) ON DELETE CASCADE
);
