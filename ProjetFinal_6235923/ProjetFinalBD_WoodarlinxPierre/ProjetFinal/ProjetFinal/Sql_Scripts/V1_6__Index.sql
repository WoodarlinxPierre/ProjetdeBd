USE ConcessionaireMercedes;
GO

-- Création d'un index non-clustered sur la colonne 'Courriel' de la table 'Utilisateur'
-- Cet index permet d'accélérer les requêtes de recherche par courriel, par exemple lors de l'authentification.
-- L'index est utile dans les procédures comme 'connexion' ou les vérifications de duplication d'email.
CREATE NONCLUSTERED INDEX IX_Utilisateur_Email
ON users.Utilisateur (Email);
GO

-- Création un index non-clustered sur la colonne 'VersionID' de la table 'Voiture'
-- Cet index est utile pour les jointures qu'on fait souvent  entre les voitures et leurs versions, 
-- notamment dans les vues ou procédures qui regroupent des informations.
CREATE NONCLUSTERED INDEX IX_Voiture_VersioID
ON Voitures.Voiture (VersioID);
GO