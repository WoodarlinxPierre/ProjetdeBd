USE [ConcessionaireMercedes]
GO
--ister toutes les voitures d’une catégorie spécifique (Standard ou Haut de Gamme) en utilisant la fonction ufn_DeterminerCategorieVoiture.
CREATE OR ALTER TRIGGER Voitures.trg_iVoitureCatégoriser
ON Voitures.Voiture
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Vérification de la catégorie pour chaque voiture insérée
    SELECT  
        i.VoitureID,  
        M.Nom AS Modele,  
        Ver.NbChevaux,  
        i.Prix,  
        Voitures.ufn_DeterminerCategorieVoiture(i.Prix, Ver.NbChevaux) AS Categorie
    FROM inserted i  -- Table temporaire contenant les nouvelles entrées
    JOIN Configurations.Version Ver
	ON i.VersionID = Ver.VersionID  
    JOIN Configurations.Modele M 
	ON Ver.ModeleID = M.ModeleID;
    
    PRINT  'Une nouvelle voiture a été ajoutée et classifiée automatiquement.';
END;
GO
--Essaie
INSERT INTO Voitures.Voiture (Couleur, Prix, Kilometrage, Disponible, VersionID)
VALUES ('Noir', 60000, 15000, 1, 1);
