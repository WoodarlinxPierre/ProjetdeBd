
USE ConcessionaireMercedes;
GO
--PROCEDURE QUI RECHERCHE DES VOITURES AVEC LES PARAMÈTRE  @Carburant @Disponible @PrixMax @Categorie
CREATE PROCEDURE Voitures.usp_RechercherVoitures
    @Carburant NVARCHAR(30) = NULL,
    @Disponible BIT = NULL,
    @PrixMax DECIMAL(18, 2) = NULL,
    @Categorie NVARCHAR(30) = NULL
AS
BEGIN
    SELECT V.VoitureID, M.Nom AS Modele, V.Prix, V.Kilometrage, Moteur.TypeCarburant
    FROM Voitures.Voiture V
    JOIN Configurationn.Versio Ver ON V.VersioID = Ver.VersioID
    JOIN Configurationn.Modele M ON Ver.ModeleID = M.ModeleID
    JOIN Configurationn.Moteur Moteur ON Ver.VersioID = Moteur.VersioID
    WHERE (@Carburant IS NULL OR Moteur.TypeCarburant = @Carburant)
      AND (@Disponible IS NULL OR V.Disponible = @Disponible)
      AND (@PrixMax IS NULL OR V.Prix <= @PrixMax)
      AND (
          @Categorie IS NULL OR
          (
            CASE 
                WHEN Ver.NbChevaux >= 400 THEN 'Sportive'
                WHEN M.TypeCarosserie LIKE '%électrique%' THEN 'Électrique'
                ELSE 'Familiale'
            END = @Categorie
          )
      );
END;
GO
