USE ConcessionaireMercedes;
go


CREATE VIEW Voitures.Vw_RechercherVoitures
AS
SELECT 
    V.VoitureID, 
    M.Nom AS Modele, 
    V.Prix, 
    V.Kilometrage, 
    Moteur.TypeCarburant,
    V.Disponible,
    CASE 
        WHEN Ver.NbChevaux >= 400 THEN 'Sportive'
        WHEN M.TypeCarosserie LIKE '%électrique%' THEN 'Électrique'
        ELSE 'Familiale'
    END AS Categorie
FROM Voitures.Voiture V
JOIN Configurationn.Versio Ver ON V.VersioID = Ver.VersioID
JOIN Configurationn.Modele M ON Ver.ModeleID = M.ModeleID
JOIN Configurationn.Moteur Moteur ON Ver.VersioID = Moteur.VersioID;

