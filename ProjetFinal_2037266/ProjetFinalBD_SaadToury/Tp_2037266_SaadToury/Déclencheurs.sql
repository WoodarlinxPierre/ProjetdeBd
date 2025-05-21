--Enregistrement automatique des victoires d�un conducteur
GO
CREATE TRIGGER racing.trg_AjoutVictoireConducteur
ON racing.Champion
AFTER INSERT
AS
BEGIN
    -- Mise � jour du nombre de victoires du conducteur
    UPDATE c
    SET c.NombreVictoires = c.NombreVictoires + 1
    FROM racing.Conducteur c
    INNER JOIN inserted i ON c.ConducteurID = i.ConducteurID;
END
GO


--Test du d�clencheur Avant insertion
SELECT ConducteurID, Nom, Prenom, NombreVictoires
FROM racing.Conducteur
WHERE ConducteurID = 1;


--Insert test
INSERT INTO racing.Champion (Annee, ModeleVoitureGagnante, ConducteurID, EcurieID)
VALUES (2025, 'Porsche 919 Hybrid', 1, 1);

--Test du d�clencheur Apr�s insertion
SELECT ConducteurID, Nom, Prenom, NombreVictoires
FROM racing.Conducteur
WHERE ConducteurID = 1;



GO
CREATE TRIGGER racing.trg_AjoutChampionTest
ON racing.Champion
AFTER INSERT
AS
BEGIN
    -- Ins�rer un nouveau champion nomm� 'Test D�clencheur'
    INSERT INTO racing.Champion (Annee, ModeleVoitureGagnante, ConducteurID, EcurieID)
    VALUES 
    (
        YEAR(GETDATE()), 
        'Test D�clencheur', 
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





































--Ajouter automatiquement un champion nomm� "Test D�clencheur"
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

    -- S�lectionner al�atoirement un conducteur et une �curie
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

    -- Ins�rer un nouveau champion nomm� "Test D�clencheur"
    INSERT INTO racing.Champion (Annee, ModeleVoitureGagnante, ConducteurID, EcurieID)
    VALUES 
    (
        YEAR(GETDATE()), 
        'Test D�clencheur', 
        @ConducteurID, 
        @EcurieID
    );

    -- Afficher le conducteur s�lectionn�
    SELECT 
        @ConducteurID AS ConducteurID, 
        @ConducteurNom AS ConducteurNom, 
        @ConducteurPrenom AS ConducteurPrenom,
        'Test D�clencheur ajout� avec succ�s.' AS Message;
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

