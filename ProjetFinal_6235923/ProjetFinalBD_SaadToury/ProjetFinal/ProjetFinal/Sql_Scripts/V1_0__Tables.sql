-- Utilisation de la base de données
USE ConcessionaireMercedes;
GO

-- TABLES

CREATE TABLE Configurationn.Fonctionnalite (
    FonctionnaliteID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Fonctionnalite PRIMARY KEY (FonctionnaliteID),
    CONSTRAINT UQ_Fonctionnalite_Nom UNIQUE (Nom)
);

CREATE TABLE Configurationn.Modele (
    ModeleID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(50) NOT NULL,
    TypeCarosserie NVARCHAR(50) NOT NULL,
    AnneeLancement DATE NOT NULL,
    CONSTRAINT PK_Modele PRIMARY KEY (ModeleID)
);

CREATE TABLE Configurationn.Versio (
    VersioID INT IDENTITY(1,1) NOT NULL,
    Nom NVARCHAR(20) NOT NULL,
    NbChevaux INT NOT NULL,
    BoiteVitesse NVARCHAR(20) NOT NULL,
    AnneeLancement DATE NOT NULL,
    Couple INT NOT NULL,
    CapReservoir INT NOT NULL,
    ModeleID INT NOT NULL,
    CONSTRAINT PK_Versio PRIMARY KEY (VersioID),
    CONSTRAINT FK_Versio_Modele FOREIGN KEY (ModeleID) REFERENCES Configurationn.Modele(ModeleID)
);

CREATE TABLE Configurationn.FonctionnaliteVersio (
    FonctionnaliteVersioID INT IDENTITY(1,1) NOT NULL,
    EstOptionel BIT NOT NULL,
    FonctionnaliteID INT NOT NULL,
    VersioID INT NOT NULL,
    CONSTRAINT PK_FonctionnaliteVersio PRIMARY KEY (FonctionnaliteVersioID),
    CONSTRAINT FK_FonctionnaliteVersio_Fonctionnalite FOREIGN KEY (FonctionnaliteID) REFERENCES Configurationn.Fonctionnalite(FonctionnaliteID),
    CONSTRAINT FK_FonctionnaliteVersio_Versio FOREIGN KEY (VersioID) REFERENCES Configurationn.Versio(VersioID)
);

CREATE TABLE Configurationn.Moteur (
    MoteurID INT IDENTITY(1,1) NOT NULL,
    TypeCarburant NVARCHAR(30) NOT NULL,
    NbCylindre INT NOT NULL,
    EstTurbocharger BIT NOT NULL DEFAULT 0,
    EstSupercharger BIT NOT NULL DEFAULT 0,
    VersioID INT NOT NULL,
    CONSTRAINT PK_Moteur PRIMARY KEY (MoteurID),
    CONSTRAINT FK_Moteur_Versio FOREIGN KEY (VersioID) REFERENCES Configurationn.Versio(VersioID)
);

CREATE TABLE Voitures.Voiture (
    VoitureID INT IDENTITY(1,1) NOT NULL,
    Couleur NVARCHAR(30) NOT NULL,
    Prix DECIMAL(18, 2) NOT NULL CHECK (Prix > 0),
    Kilometrage INT NOT NULL,
    Disponible BIT NOT NULL,
    VersioID INT NOT NULL,
    CONSTRAINT PK_Voiture PRIMARY KEY (VoitureID),
    CONSTRAINT FK_Voiture_Versio FOREIGN KEY (VersioID) REFERENCES Configurationn.Versio(VersioID) ON DELETE CASCADE
);
