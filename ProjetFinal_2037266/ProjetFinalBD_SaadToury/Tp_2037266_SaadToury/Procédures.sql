--Trouver les conducteurs nés entre deux dates
GO
CREATE PROCEDURE racing.usp_ConducteursNesEntreDeuxDates
(
    @DateDebut DATE,
    @DateFin DATE
)
AS
BEGIN
    SELECT ConducteurID, Nom, Prenom, DateNaissance, PaysOrigine, NombreVictoires
    FROM racing.Conducteur
    WHERE DateNaissance BETWEEN @DateDebut AND @DateFin
    ORDER BY DateNaissance ASC;
END
GO

-- ✅ Test de la procédure :
EXEC racing.usp_ConducteursNesEntreDeuxDates 
    @DateDebut = '1960-01-01', 
    @DateFin = '1970-12-31';
GO

--Mettre à jour le nombre de victoires d'un conducteur
GO
CREATE PROCEDURE racing.usp_MettreAJourNombreVictoiresConducteur
(
    @ConducteurID INT,
    @NouveauNombreVictoires INT
)
AS
BEGIN
    -- Vérification si le nombre de victoires est valide
    IF @NouveauNombreVictoires < 0
    BEGIN
        SELECT 'Le nombre de victoires doit être supérieur ou égal à zéro.' AS [Message d''erreur];
        RETURN;
    END

    -- Vérification si le conducteur existe
    IF NOT EXISTS (SELECT 1 FROM racing.Conducteur WHERE ConducteurID = @ConducteurID)
    BEGIN
        SELECT 'Aucun conducteur trouvé avec cet ID.' AS [Message d''erreur];
        RETURN;
    END

    -- Mise à jour du nombre de victoires
    UPDATE racing.Conducteur
    SET NombreVictoires = @NouveauNombreVictoires
    WHERE ConducteurID = @ConducteurID;

    SELECT 'Le nombre de victoires du conducteur a été mis à jour avec succès.' AS [Message];
END
GO

-- ✅ Test de la procédure :
EXEC racing.usp_MettreAJourNombreVictoiresConducteur 
    @ConducteurID = 1, 
    @NouveauNombreVictoires = 10;
GO

--Obtenir le palmarès complet d'un conducteur
GO
CREATE PROCEDURE racing.usp_PalmaresConducteur
(
    @ConducteurID INT
)
AS
BEGIN
    -- Vérifier si le conducteur existe
    IF NOT EXISTS (SELECT 1 FROM racing.Conducteur WHERE ConducteurID = @ConducteurID)
    BEGIN
        SELECT 'Aucun conducteur trouvé avec cet ID.' AS [Message d''erreur];
        RETURN;
    END

    -- Afficher le palmarès complet du conducteur
    SELECT 
        c.Nom AS ConducteurNom,
        c.Prenom AS ConducteurPrenom,
        DATEDIFF(YEAR, c.DateNaissance, GETDATE()) AS Age,
        c.NombreVictoires,
        ch.Annee AS AnneeVictoire,
        ch.ModeleVoitureGagnante,
        e.Nom AS Ecurie
    FROM 
        racing.Conducteur c
    INNER JOIN 
        racing.Champion ch ON c.ConducteurID = ch.ConducteurID
    INNER JOIN 
        racing.Ecurie e ON ch.EcurieID = e.EcurieID
    WHERE 
        c.ConducteurID = @ConducteurID
    ORDER BY 
        ch.Annee ASC;
END
GO

-- ✅ Test de la procédure :
EXEC racing.usp_PalmaresConducteur 
    @ConducteurID = 1;
GO
