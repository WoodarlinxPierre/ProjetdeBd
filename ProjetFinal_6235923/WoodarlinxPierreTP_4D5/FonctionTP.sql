
use [ConcessionaireMercedes]
go
--Cette fonction sert à déterminer si une voiture est standart ou haute gamme
CREATE OR ALTER  FUNCTION Voitures.ufn_DeterminerCategorieVoiture (@Prix Int , @NbChevaux INT)  
RETURNS NVARCHAR(20)  
AS  
BEGIN  
    DECLARE @Categorie NVARCHAR(20);  

    IF @Prix > 80000 OR @NbChevaux > 350  
        SET @Categorie = 'Haut de Gamme';  
    ELSE  
        SET @Categorie = 'Standard';  

    RETURN @Categorie;  
END;
--Application de la fonctions
SELECT  
    V.VoitureID,  
    M.Nom AS Modele,  
    Ver.NbChevaux,  
    V.Prix,  
    Voitures.ufn_DeterminerCategorieVoiture(V.Prix, Ver.NbChevaux) AS Categorie
FROM Voitures.Voiture V  
JOIN Configurations.Version Ver ON V.VersionID = Ver.VersionID  
JOIN Configurations.Modele M ON Ver.ModeleID = M.ModeleID;