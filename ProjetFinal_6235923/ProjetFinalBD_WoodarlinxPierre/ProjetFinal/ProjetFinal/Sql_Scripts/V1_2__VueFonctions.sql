USE ConcessionaireMercedes;
GO

-- Vue qui regroupe les voitures disponibles par catégorie et retourne des statistiques Versio
CREATE OR ALTER VIEW Voitures.Vw_Stats_Categorie AS
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
INNER JOIN Configurationn.Versio Ver ON V.VersioID = Ver.VersioID
INNER JOIN Configurationn.Modele M ON Ver.ModeleID = M.ModeleID
WHERE V.Disponible = 1
GROUP BY 
    CASE 
        WHEN Ver.NbChevaux >= 400 THEN 'Sportive'
        WHEN M.TypeCarosserie LIKE '%électrique%' THEN 'Électrique'
        ELSE 'Familiale' 
    END;
GO
