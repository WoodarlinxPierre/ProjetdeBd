USE [ConcessionaireMercedes]
GO
--ister toutes les voitures d�une cat�gorie sp�cifique (Standard ou Haut de Gamme) en utilisant la fonction ufn_DeterminerCategorieVoiture.
CREATE OR ALTER TRIGGER Voitures.trg_iVoitureCat�goriser
ON Voitures.Voiture
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- V�rification de la cat�gorie pour chaque voiture ins�r�e
    SELECT  
        i.VoitureID,  
        M.Nom AS Modele,  
        Ver.NbChevaux,  
        i.Prix,  
        Voitures.ufn_DeterminerCategorieVoiture(i.Prix, Ver.NbChevaux) AS Categorie
    FROM inserted i  -- Table temporaire contenant les nouvelles entr�es
    JOIN Configurations.Version Ver
	ON i.VersionID = Ver.VersionID  
    JOIN Configurations.Modele M 
	ON Ver.ModeleID = M.ModeleID;
    
    PRINT  'Une nouvelle voiture a �t� ajout�e et classifi�e automatiquement.';
END;
GO
--Essaie
INSERT INTO Voitures.Voiture (Couleur, Prix, Kilometrage, Disponible, VersionID)
VALUES ('Noir', 60000, 15000, 1, 1);
