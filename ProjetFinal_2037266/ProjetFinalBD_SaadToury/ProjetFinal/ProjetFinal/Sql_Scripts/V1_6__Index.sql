-- Création d'un index non-clustered sur la colonne 'Email' de la table 'Utilisateur'
-- Cet index permet d'accélérer les requêtes de recherche par email dans la table 'Utilisateur'.
-- L'index est particulièrement utile dans des procédures comme 'USP_AuthClient' où 
-- la recherche d'un utilisateur se fait fréquemment en fonction de l'email.
-- Un index non-clustered permet une recherche plus rapide sur cette colonne, notamment 
-- pour les opérations de login ou toute autre opération de filtrage sur l'email.
CREATE NONCLUSTERED INDEX IX_Utilisateur_Email
ON users.Utilisateur (Email);
GO

-- Création d'un index non-clustered sur la colonne 'ConducteurId' de la table 'Photo'
-- Cet index est destiné à accélérer les requêtes qui récupèrent des photos en fonction de l'ID du conducteur.
-- Par exemple, si tu veux obtenir toutes les photos associées à un conducteur spécifique,
-- l'index sur 'ConducteurId' permettra à SQL Server de trouver ces photos beaucoup plus rapidement.
-- Cela peut améliorer les performances des requêtes qui filtrent ou rejoignent la table 'Photo' 
-- en utilisant l'identifiant du conducteur (ConducteurId).
CREATE NONCLUSTERED INDEX IX_Photo_ConducteurId
ON racing.Photo (ConducteurId);
GO