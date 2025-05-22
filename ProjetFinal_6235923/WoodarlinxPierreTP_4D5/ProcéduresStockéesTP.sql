use [ConcessionaireMercedes]
go
--Permet d'obtenir les voitures disponibles pour un modèle
CREATE OR ALTER  PROCEDURE Voitures.usp_ObtenirVoituresParModele
    @ModeleID INT
AS
BEGIN
    -- Vérification si le modèle existe
    IF NOT EXISTS (SELECT 1 FROM Configurations.Modele WHERE ModeleID = @ModeleID)
    BEGIN
        PRINT ' Erreur : Le modèle spécifié n’existe pas.';
        RETURN;
    END;

    -- Sélection des voitures disponibles pour ce modèle
    SELECT  
        M.Nom AS Modele,
        V.VoitureID,
        V.Couleur,
        V.Prix,
        V.Kilometrage,
        V.Disponible
    FROM Voitures.Voiture V
    JOIN Configurations.Version Ver ON V.VersionID = Ver.VersionID
    JOIN Configurations.Modele M ON Ver.ModeleID = M.ModeleID
    WHERE M.ModeleID = @ModeleID
    AND V.Disponible = 1;
END;

go
-- trouver les voitures du modèles 2
EXEC Voitures.usp_ObtenirVoituresParModele
    @ModeleID = 2;

	go


	--- Montre les votiures selon la categorie(standard ou haute gamme) recu en paramètre
CREATE PROCEDURE Voitures.usp_ListerVoituresParCategorie
    @Categorie NVARCHAR(20)
AS
BEGIN
    -- Vérification de la catégorie demandée
    IF @Categorie NOT IN ('Standard', 'Haut de Gamme')
    BEGIN
        PRINT ' Erreur : La catégorie doit être "Standard" ou "Haut de Gamme".';
        RETURN;
    END;

    -- Sélection des voitures correspondant à la catégorie demandée
    SELECT  
        V.VoitureID,  
        M.Nom AS Modele,  
        Ver.NbChevaux,  
        V.Prix,  
        Voitures.ufn_DeterminerCategorieVoiture(V.Prix, Ver.NbChevaux) AS Categorie
    FROM Voitures.Voiture V  
    JOIN Configurations.Version Ver ON V.VersionID = Ver.VersionID  
    JOIN Configurations.Modele M ON Ver.ModeleID = M.ModeleID
    WHERE Voitures.ufn_DeterminerCategorieVoiture(V.Prix, Ver.NbChevaux) = @Categorie;
END;
--Éxecutcion de la procédures
EXEC Voitures.usp_ListerVoituresParCategorie @Categorie = 'Haut de Gamme';
