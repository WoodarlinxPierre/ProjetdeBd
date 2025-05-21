--Enregistrement automatique des victoires d’un conducteur
GO
CREATE TRIGGER racing.trg_AjoutVictoireConducteur
ON racing.Champion
AFTER INSERT
AS
BEGIN
    -- Mise à jour du nombre de victoires du conducteur
    UPDATE c
    SET c.NombreVictoires = c.NombreVictoires + 1
    FROM racing.Conducteur c
    INNER JOIN inserted i ON c.ConducteurID = i.ConducteurID;
END
GO


--Test du déclencheur Avant insertion
SELECT ConducteurID, Nom, Prenom, NombreVictoires
FROM racing.Conducteur
WHERE ConducteurID = 1;


--Insert test
INSERT INTO racing.Champion (Annee, ModeleVoitureGagnante, ConducteurID, EcurieID)
VALUES (2025, 'Porsche 919 Hybrid', 1, 1);

--Test du déclencheur Après insertion
SELECT ConducteurID, Nom, Prenom, NombreVictoires
FROM racing.Conducteur
WHERE ConducteurID = 1;



GO
CREATE TRIGGER racing.trg_AjoutChampionTest
ON racing.Champion
AFTER INSERT
AS
BEGIN
    -- Insérer un nouveau champion nommé 'Test Déclencheur'
    INSERT INTO racing.Champion (Annee, ModeleVoitureGagnante, ConducteurID, EcurieID)
    VALUES 
    (
        YEAR(GETDATE()), 
        'Test Déclencheur', 
        (SELECT TOP 1 ConducteurID FROM racing.Conducteur ORDER BY NEWID()), 
        (SELECT TOP 1 EcurieID FROM racing.Ecurie ORDER BY NEWID())
    );
END
GO

SELECT TOP(5) ChampionID, Annee, ModeleVoitureGagnante, ConducteurID, EcurieID
FROM racing.Champion
ORDER BY ChampionID DESC;


INSERT INTO racing.Champion (Annee, ModeleVoitureGagnante, ConducteurID, EcurieID)
VALUES (2025, 'Ferrari SF90', 1, 1);


SELECT TOP(5) ChampionID, Annee, ModeleVoitureGagnante, ConducteurID, EcurieID
FROM racing.Champion
ORDER BY ChampionID DESC;





































--Ajouter automatiquement un champion nommé "Test Déclencheur"
GO
CREATE TRIGGER racing.trg_AjoutChampionTest2
ON racing.Champion
AFTER INSERT
AS
BEGIN
    DECLARE @ConducteurID INT;
    DECLARE @EcurieID INT;
    DECLARE @ConducteurNom NVARCHAR(50);
    DECLARE @ConducteurPrenom NVARCHAR(50);

    -- Sélectionner aléatoirement un conducteur et une écurie
    SELECT TOP 1 
        @ConducteurID = ConducteurID, 
        @ConducteurNom = Nom,
        @ConducteurPrenom = Prenom
    FROM racing.Conducteur
    ORDER BY NEWID();

    SELECT TOP 1 
        @EcurieID = EcurieID 
    FROM racing.Ecurie
    ORDER BY NEWID();

    -- Insérer un nouveau champion nommé "Test Déclencheur"
    INSERT INTO racing.Champion (Annee, ModeleVoitureGagnante, ConducteurID, EcurieID)
    VALUES 
    (
        YEAR(GETDATE()), 
        'Test Déclencheur', 
        @ConducteurID, 
        @EcurieID
    );

    -- Afficher le conducteur sélectionné
    SELECT 
        @ConducteurID AS ConducteurID, 
        @ConducteurNom AS ConducteurNom, 
        @ConducteurPrenom AS ConducteurPrenom,
        'Test Déclencheur ajouté avec succès.' AS Message;
END
GO



SELECT TOP(5) ChampionID, Annee, ModeleVoitureGagnante, ConducteurID, EcurieID
FROM racing.Champion
ORDER BY ChampionID DESC;



INSERT INTO racing.Champion (Annee, ModeleVoitureGagnante, ConducteurID, EcurieID)
VALUES (2025, 'Ferrari SF90', 2, 1);




SELECT TOP(5) ChampionID, Annee, ModeleVoitureGagnante, ConducteurID, EcurieID
FROM racing.Champion
ORDER BY ChampionID DESC;

