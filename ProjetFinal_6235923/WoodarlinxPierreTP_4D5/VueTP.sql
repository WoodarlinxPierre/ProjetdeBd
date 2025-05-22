
use [ConcessionaireMercedes]
go
-- cr��e une vue pour classifi� les voitures par Sportive,�l�ctrique Familiale
CREATE or alter VIEW Voitures.Vue_Infos_Voitures AS
SELECT Distinct V.VoitureID,M.Nom AS Modele, M.TypeCarosserie, Ver.AnneeLancement, Moteur.TypeCarburant, Moteur.NbCylindre, Ver.NbChevaux,Ver.BoiteVitesse, V.Couleur,V.Prix, V.Kilometrage,
    -- Cat�gorisation avanc�e des voitures en fonction de leur puissance
    CASE 
        WHEN Ver.NbChevaux >= 400 THEN 'Sportive'
        WHEN M.TypeCarosserie = 'SUV �lectrique' OR M.TypeCarosserie = 'Berline �lectrique' THEN '�lectrique'
        ELSE 'Familiale' 
    END AS Categorie
	
FROM Voitures.Voiture V
inner JOIN Configurations.Version Ver 
ON V.VersionID = Ver.VersionID
inner JOIN Configurations.Modele M 
ON Ver.ModeleID = M.ModeleID
inner JOIN Configurations.Moteur Moteur 
ON Ver.VersionID = Moteur.VersionID
where V.Disponible =1 

go
SELECT * FROM Voitures.Vue_Infos_Voitures;

