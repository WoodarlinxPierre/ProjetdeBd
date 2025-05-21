USE ConcessionaireMercedes;
GO

-- Vue qui regroupe les voitures disponibles par catégorie et retourne des statistiques agrégées
CREATE OR ALTER VIEW Voitures.Vue_Stats_Categorie AS
SELECT 
    CASE 
        WHEN Ver.NbChevaux >= 400 THEN 'Sportive'
        WHEN M.TypeCarosserie LIKE '%électrique%' THEN 'Électrique'
        ELSE 'Familiale' 
    END AS Categorie,
    COUNT(V.VoitureID) AS NombreVoitures,
    AVG(V.Prix) AS PrixMoyen,
    AVG(V.Kilometrage) AS KilometrageMoyen
FROM Voitures.Voiture V
INNER JOIN Configuration.Version Ver ON V.VersionID = Ver.VersionID
INNER JOIN Configuration.Modele M ON Ver.ModeleID = M.ModeleID
WHERE V.Disponible = 1
GROUP BY 
    CASE 
        WHEN Ver.NbChevaux >= 400 THEN 'Sportive'
        WHEN M.TypeCarosserie LIKE '%électrique%' THEN 'Électrique'
        ELSE 'Familiale' 
    END;
GO
