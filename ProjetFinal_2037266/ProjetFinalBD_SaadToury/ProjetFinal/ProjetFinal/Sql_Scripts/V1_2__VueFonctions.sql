USE ProjetFinalBdLeMans_2037266;
GO

GO
CREATE OR ALTER VIEW dbo.Vue_Conducteurs_Victoires AS
SELECT 
    c.ConducteurID,
    c.Nom AS ConducteurNom,
    c.Prenom AS ConducteurPrenom,
    DATEDIFF(YEAR, c.DateNaissance, GETDATE()) AS Age,
    c.PaysOrigine,
    COUNT(ch.ChampionID) AS NombreVictoiresTotales,
    COUNT(DISTINCT ch.ModeleVoitureGagnante) AS NombreVoituresDifferentGagnees
FROM 
    racing.Conducteur c
LEFT JOIN 
    racing.Champion ch ON c.ConducteurID = ch.ConducteurID
GROUP BY 
    c.ConducteurID, c.Nom, c.Prenom, c.DateNaissance, c.PaysOrigine;

GO


SELECT * FROM dbo.Vue_Conducteurs_Victoires;