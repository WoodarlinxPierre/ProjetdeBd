
GO
CREATE VIEW Vue_ConducteursNesEntreDeuxDates AS
    SELECT ConducteurID, Nom, Prenom, DateNaissance, PaysOrigine, NombreVictoires
    FROM racing.Conducteur
GO

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




