use [ConcessionaireMercedes]

go 

--Q1 Une requête sur une table, avec une clause WHERE et une clause ORDER BY (Liste des voitures Mercedes qui coute plus de 50 000$ en ordre décroissant)
select ve.[Nom],ve.[NbChevaux],ve.[BoiteVitesse],v.[Couleur],v.[Prix]
from [Configurations].[Version]Ve
inner join [Voitures].[Voiture]V
on Ve.VersionID =v.VersionID
WHERE v.Prix >50000
ORDER BY v.[Prix] desc

--Q2 Une requête avec un INNER JOIN entre 2 tables avec un GROUP BY et une fonction d’agrégation (  nombre de fonctionalité par  version de Mercedes)
select ve.[Nom],COUNT(f.[FonctionnaliteID]) as [Nb de fonctionalité]
from [Configurations].[Version]Ve
inner join [Configurations].[FonctionnaliteVersion]fv
on Ve.VersionID =fv.VersionID
inner join [Configurations].[Fonctionnalite]f
on f.FonctionnaliteID =fv.FonctionnaliteID
group by ve.Nom

--Q3 Une requête qui part de votre requête en 2) et qui ajoute la clause HAVING (nombre de fonctionalité par  version de Mercedes ou il y en a plus ou égale à 10)
select ve.[Nom],COUNT(f.[FonctionnaliteID]) as [Nb de fonctionalité]
from [Configurations].[Version]Ve
inner join [Configurations].[FonctionnaliteVersion]fv
on Ve.VersionID =fv.VersionID
inner join [Configurations].[Fonctionnalite]f
on f.FonctionnaliteID =fv.FonctionnaliteID
group by ve.Nom
Having  COUNT(f.[FonctionnaliteID]) >= 10

--Q4 Une requête qui a un INNER JOIN avec vos 3 tables. ( Nombre de version Mercedes par fornctionalité)
select f.Nom ,count(ve.VersionID) as [nb de version de mercedes par fonctionalité]
from [Configurations].[Version]Ve
inner join [Configurations].[FonctionnaliteVersion]fv
on Ve.VersionID =fv.VersionID
inner join [Configurations].[Fonctionnalite]f
on f.FonctionnaliteID =fv.FonctionnaliteID
group by f.Nom

--Q5 Une requête qui a besoin d’utiliser une sous-requête.(Trouver les modèles Mercedes qui ont du diesel )
SELECT [Nom],[TypeCarosserie],[AnneeLancement]
FROM  [Configurations].[Modele]m
WHERE m.ModeleID in (
    SELECT DISTINCT v.ModeleID 
    FROM [Configurations].[Version] v 
   inner  JOIN [Configurations].[Moteur]MO
   ON v.VersionID = MO.VersionID
    WHERE MO.TypeCarburant = 'Diesel'
);
