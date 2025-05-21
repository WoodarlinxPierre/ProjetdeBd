
USE ConcessionaireMercedes;
GO

CREATE PROCEDURE Voitures.usp_RechercherVoitures
    @Carburant NVARCHAR(30) = NULL,
    @Disponible BIT = NULL,
    @PrixMax DECIMAL(18, 2) = NULL,
    @Categorie NVARCHAR(30) = NULL
AS
BEGIN
    SELECT V.VoitureID, M.Nom AS Modele, V.Prix, V.Kilometrage, Moteur.TypeCarburant
    FROM Voitures.Voiture V
    JOIN Configurations.Version Ver ON V.VersionID = Ver.VersionID
    JOIN Configurations.Modele M ON Ver.ModeleID = M.ModeleID
    JOIN Configurations.Moteur Moteur ON Ver.VersionID = Moteur.VersionID
    WHERE (@Carburant IS NULL OR Moteur.TypeCarburant = @Carburant)
      AND (@Disponible IS NULL OR V.Disponible = @Disponible)
      AND (@PrixMax IS NULL OR V.Prix <= @PrixMax)
      AND (
          @Categorie IS NULL OR
          (
            CASE 
                WHEN Ver.NbChevaux >= 400 THEN 'Sportive'
                WHEN M.TypeCarrosserie LIKE '%électrique%' THEN 'Électrique'
                ELSE 'Familiale'
            END = @Categorie
          )
      );
END;
GO
