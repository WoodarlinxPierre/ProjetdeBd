USE TpBdLeMans_SaadToury_2037266;
GO

-- Sélectionner les conducteurs avec plus de 3 victoires, triés par nombre de victoires décroissant
SELECT *  
FROM racing.Conducteur  
WHERE NombreVictoires > 3  
ORDER BY NombreVictoires DESC;

-- Compter le nombre de courses gagnées par chaque écurie
SELECT e.Nom AS Ecurie, COUNT(c.CourseID) AS NombreCoursesGagnees  
FROM racing.Ecurie e  
INNER JOIN racing.Champion ch ON e.EcurieID = ch.EcurieID  
INNER JOIN racing.Course c ON ch.ChampionID = c.ChampionID  
GROUP BY e.Nom;

-- Afficher uniquement les écuries ayant gagné plus de 5 courses
SELECT e.Nom AS Ecurie, COUNT(c.CourseID) AS NombreCoursesGagnees  
FROM racing.Ecurie e  
INNER JOIN racing.Champion ch ON e.EcurieID = ch.EcurieID  
INNER JOIN racing.Course c ON ch.ChampionID = c.ChampionID  
GROUP BY e.Nom  
HAVING COUNT(c.CourseID) > 5;



-- Afficher les courses avec leurs circuits et les écuries gagnantes
SELECT c.Nom AS Course, ci.Nom AS Circuit, e.Nom AS Ecurie  
FROM racing.Course c  
INNER JOIN ref.Circuit ci ON c.CircuitID = ci.CircuitID  
INNER JOIN racing.Champion ch ON c.ChampionID = ch.ChampionID  
INNER JOIN racing.Ecurie e ON ch.EcurieID = e.EcurieID;




-- Trouver les conducteurs ayant gagné au moins une course avec une écurie qui a plus de 5 victoires
SELECT DISTINCT c.Nom, c.Prenom  
FROM racing.Conducteur c  
WHERE c.ConducteurID IN (
    SELECT ch.ConducteurID  
    FROM racing.Champion ch  
    INNER JOIN racing.Ecurie e ON ch.EcurieID = e.EcurieID  
    INNER JOIN racing.Course co ON ch.ChampionID = co.ChampionID  
    GROUP BY ch.ConducteurID
    HAVING COUNT(co.CourseID) > 5  
);


-- Sélectionner les voitures dont la vitesse maximale est supérieure à la moyenne des vitesses des voitures ayant participé aux 24 Heures du Mans
SELECT v.Nom AS Voiture, m.VitesseMax  
FROM racing.Voiture v  
INNER JOIN ref.Modele m ON v.ModeleID = m.ModeleID  
WHERE m.VitesseMax > (
    -- Calcul de la vitesse maximale moyenne des voitures ayant participé aux 24 Heures du Mans
    SELECT AVG(m2.VitesseMax)  
    FROM racing.Voiture v2  
    INNER JOIN ref.Modele m2 ON v2.ModeleID = m2.ModeleID  
    WHERE v2.VoitureID IN (
        -- Sélectionner les voitures qui ont participé aux 24 Heures du Mans
        SELECT DISTINCT e.VoitureID  
        FROM racing.Ecurie e  
        INNER JOIN racing.Champion ch ON e.EcurieID = ch.EcurieID  
        INNER JOIN racing.Course c ON ch.ChampionID = c.ChampionID  
        WHERE c.Nom LIKE '%24 Heures du Mans%'  
    )
);

