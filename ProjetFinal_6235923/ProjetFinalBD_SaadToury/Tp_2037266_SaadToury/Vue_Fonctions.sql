USE TpBdLeMans_SaadToury_2037266;
GO

GO
CREATE OR ALTER FUNCTION dbo.ufn_NombreVoituresDifGagnees
(@ConducteurID INT)
RETURNS INT
AS
BEGIN
    RETURN(
        SELECT COUNT(DISTINCT ch.ModeleVoitureGagnante)
        FROM racing.Champion ch
        WHERE ch.ConducteurID = @ConducteurID
    )
END
GO
SELECT dbo.ufn_NombreVoituresDifGagnees(2) AS NombreVoituresDifférentesGagnées;


GO
CREATE OR ALTER VIEW dbo.Vue_Conducteurs_Victoires AS
SELECT TOP(100) 
    c.Nom AS ConducteurNom,
    c.Prenom AS ConducteurPrenom,
    DATEDIFF(YEAR, c.DateNaissance, GETDATE()) AS Age,
    c.PaysOrigine,
    c.NombreVictoires,
    ch.ModeleVoitureGagnante AS ModeleVoitureGagnante
FROM 
    racing.Conducteur c
INNER JOIN 
    racing.Champion ch ON c.ConducteurID = ch.ConducteurID 
ORDER BY 
    C.NombreVictoires DESC;
GO


SELECT * FROM dbo.Vue_Conducteurs_Victoires;