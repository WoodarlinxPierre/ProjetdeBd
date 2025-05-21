USE ConcessionaireMercedes;

GO
-- Insertion des anciens mod�les
INSERT INTO Configuration.Modele (Nom, TypeCarosserie, AnneeLancement)
VALUES 
('Classe A', 'Berline', '2018-01-01'),
('Classe C', 'Berline', '2020-01-01'),
('Classe G', 'SUV', '2021-01-01'),
('Classe E', 'Berline', '2019-01-01'),
('Classe S', 'Limousine', '2022-01-01'),

-- Insertion des nouveaux mod�les
('Classe A', 'Hatchback', '2023-01-01'),
('Classe B', 'MPV', '2022-01-01'),
('GLA', 'SUV', '2023-01-01'),
('GLC', 'SUV', '2022-01-01'),
('EQC', 'SUV �lectrique', '2022-01-01');
GO

-- Insertion des anciennes versions
INSERT INTO Configuration.Version (Nom, NbChevaux, BoiteVitesse, AnneeLancement, Couple, CapReservoir, ModeleID)
VALUES 
('AMG A35', 306, 'Automatique', '2018-01-01', 400, 50, 1),
('AMG C63', 510, 'Automatique', '2020-01-01', 700, 66, 2),
('G63 AMG', 585, 'Automatique', '2021-01-01', 850, 100, 3),
('E300', 258, 'Automatique', '2019-01-01', 370, 66, 4),
('S500', 435, 'Automatique', '2022-01-01', 520, 80, 5),

-- Insertion des nouvelles versions
('A180', 136, 'Manuelle', '2023-01-01', 200, 50, 6),
('B200', 163, 'Automatique', '2022-01-01', 250, 60, 7),
('GLA 250', 224, 'Automatique', '2023-01-01', 350, 50, 8),
('GLC 300', 258, 'Automatique', '2022-01-01', 370, 66, 9),
('EQC 400', 408, 'Automatique', '2022-01-01', 760, 85, 10);
GO

-- Insertion des anciennes fonctionnalit�s
INSERT INTO Configuration.Fonctionnalite (Nom)
VALUES 
('Toit panoramique'),
('Si�ges chauffants'),
('Syst�me audio haut de gamme'),
('Cam�ra de recul'),
('Assistance au stationnement'),
('Climatisation 4 zones'),
('�cran tactile 12 pouces'),
('Conduite autonome niveau 2'),
('Pack AMG Performance'),
('Peinture m�tallis�e'),

-- Insertion des nouvelles fonctionnalit�s
('R�gulateur de vitesse adaptatif'),
('Affichage t�te haute'),
('Assistance au maintien de voie'),
('Port de recharge sans fil'),
('Syst�me de d�tection de fatigue'),
('Affichage num�rique 12,3 pouces'),
('Assistance au freinage d�urgence'),
('Parking assist�'),
('Phares � LED haute performance'),
('Alarme anti-vol');
GO

-- Insertion des anciennes associations de fonctionnalit�s avec les versions
INSERT INTO Configuration.FonctionnaliteVersion (EstOptionel, FonctionnaliteID, VersionID)
VALUES 
-- Version 1 (AMG A35)
(0, 1, 1), -- Toit panoramique
(1, 2, 1), -- Si�ges chauffants (optionnel)
(0, 3, 1), -- Syst�me audio haut de gamme
(1, 4, 1), -- Cam�ra de recul (optionnel)
(0, 5, 1), -- Assistance au stationnement
(1, 6, 1), -- Climatisation 4 zones (optionnel)
(0, 7, 1), -- �cran tactile 12 pouces
(1, 8, 1), -- Conduite autonome niveau 2 (optionnel)
(0, 9, 1), -- Pack AMG Performance
(1, 10, 1), -- Peinture m�tallis�e (optionnel)

-- Version 2 (AMG C63)
(0, 1, 2), -- Toit panoramique
(1, 2, 2), -- Si�ges chauffants (optionnel)
(0, 3, 2), -- Syst�me audio haut de gamme
(1, 4, 2), -- Cam�ra de recul (optionnel)
(0, 5, 2), -- Assistance au stationnement
(1, 6, 2), -- Climatisation 4 zones (optionnel)
(0, 7, 2), -- �cran tactile 12 pouces
(1, 8, 2), -- Conduite autonome niveau 2 (optionnel)
(0, 9, 2), -- Pack AMG Performance
(1, 10, 2), -- Peinture m�tallis�e (optionnel)

-- Version 3 (G63 AMG)
(0, 1, 3), -- Toit panoramique
(1, 2, 3), -- Si�ges chauffants (optionnel)
(0, 3, 3), -- Syst�me audio haut de gamme
(1, 4, 3), -- Cam�ra de recul (optionnel)
(0, 5, 3), -- Assistance au stationnement
(1, 6, 3), -- Climatisation 4 zones (optionnel)
(0, 7, 3), -- �cran tactile 12 pouces
(1, 8, 3), -- Conduite autonome niveau 2 (optionnel)
(0, 9, 3), -- Pack AMG Performance
(1, 10, 3), -- Peinture m�tallis�e (optionnel)

-- Version 4 (E300)
(0, 1, 4), -- Toit panoramique
(1, 2, 4), -- Si�ges chauffants (optionnel)
(0, 3, 4), -- Syst�me audio haut de gamme
(1, 4, 4), -- Cam�ra de recul (optionnel)
(0, 5, 4), -- Assistance au stationnement
(1, 6, 4), -- Climatisation 4 zones (optionnel)
(0, 7, 4), -- �cran tactile 12 pouces
(1, 8, 4), -- Conduite autonome niveau 2 (optionnel)
(0, 9, 4), -- Pack AMG Performance
(1, 10, 4), -- Peinture m�tallis�e (optionnel)

-- Version 5 (S500)
(0, 1, 5), -- Toit panoramique
(1, 2, 5), -- Si�ges chauffants (optionnel)
(0, 3, 5), -- Syst�me audio haut de gamme
(1, 4, 5), -- Cam�ra de recul (optionnel)
(0, 5, 5), -- Assistance au stationnement
(1, 6, 5), -- Climatisation 4 zones (optionnel)
(0, 7, 5), -- �cran tactile 12 pouces
(1, 8, 5), -- Conduite autonome niveau 2 (optionnel)
(0, 9, 5), -- Pack AMG Performance
(1, 10, 5), -- Peinture m�tallis�e (optionnel)

-- Version 6 (A180)
(0, 1, 6), -- Toit panoramique
(1, 2, 6), -- Si�ges chauffants (optionnel)
(0, 3, 6), -- Syst�me audio haut de gamme
(1, 4, 6), -- Cam�ra de recul (optionnel)
(0, 5, 6), -- Assistance au stationnement
(1, 6, 6), -- Climatisation 4 zones (optionnel)
(0, 7, 6), -- �cran tactile 12 pouces
(1, 8, 6), -- Conduite autonome niveau 2 (optionnel)
(0, 9, 6), -- Pack AMG Performance
(1, 10, 6), -- Peinture m�tallis�e (optionnel)

-- Version 7 (B200)
(0, 1, 7), -- Toit panoramique
(1, 2, 7), -- Si�ges chauffants (optionnel)
(0, 3, 7), -- Syst�me audio haut de gamme
(1, 4, 7), -- Cam�ra de recul (optionnel)
(0, 5, 7), -- Assistance au stationnement
(1, 6, 7), -- Climatisation 4 zones (optionnel)
(0, 7, 7), -- �cran tactile 12 pouces
(1, 8, 7), -- Conduite autonome niveau 2 (optionnel)
(0, 9, 7), -- Pack AMG Performance
(1, 10, 7), -- Peinture m�tallis�e (optionnel)

-- Version 8 (GLA 250)
(0, 1, 8), -- Toit panoramique
(1, 2, 8), -- Si�ges chauffants (optionnel)
(0, 3, 8), -- Syst�me audio haut de gamme
(1, 4, 8), -- Cam�ra de recul (optionnel)
(0, 5, 8), -- Assistance au stationnement
(1, 6, 8), -- Climatisation 4 zones (optionnel)
(0, 7, 8), -- �cran tactile 12 pouces
(1, 8, 8), -- Conduite autonome niveau 2 (optionnel)
(0, 9, 8), -- Pack AMG Performance
(1, 10, 8), -- Peinture m�tallis�e (optionnel)

-- Version 9 (GLC 300)
(0, 1, 9), -- Toit panoramique
(1, 2, 9), -- Si�ges chauffants (optionnel)
(0, 3, 9), -- Syst�me audio haut de gamme
(1, 4, 9), -- Cam�ra de recul (optionnel)
(0, 5, 9), -- Assistance au stationnement
(1, 6, 9), -- Climatisation 4 zones (optionnel)
(0, 7, 9), -- �cran tactile 12 pouces
(1, 8, 9), -- Conduite autonome niveau 2 (optionnel)
(0, 9, 9), -- Pack AMG Performance
(1, 10, 9), -- Peinture m�tallis�e (optionnel)

-- Version 10 (EQC 400)
(0, 1, 10), -- Toit panoramique
(1, 2, 10), -- Si�ges chauffants (optionnel)
(0, 3, 10), -- Syst�me audio haut de gamme
(1, 4, 10), -- Cam�ra de recul (optionnel)
(0, 5, 10), -- Assistance au stationnement
(1, 6, 10), -- Climatisation 4 zones (optionnel)
(0, 7, 10), -- �cran tactile 12 pouces
(1, 8, 10), -- Conduite autonome niveau 2 (optionnel)
(0, 9, 10), -- Pack AMG Performance
(1, 10, 10); -- Peinture m�tallis�e (optionnel)
GO

-- Insertion des anciens moteurs
INSERT INTO Configuration.Moteur (TypeCarburant, NbCylindre, EstTurbocharger, EstSupercharger, VersionID)
VALUES 
('Essence', 4, 1, 0, 1), -- AMG A35
('Essence', 8, 1, 0, 2), -- AMG C63
('Essence', 8, 1, 0, 3), -- G63 AMG
('Diesel', 6, 1, 0, 4), -- E300
('Essence', 6, 1, 0, 5), -- S500

-- Insertion des nouveaux moteurs
('Essence', 4, 1, 0, 6), -- A180
('Essence', 4, 1, 0, 7), -- B200
('Essence', 4, 1, 0, 8), -- GLA 250
('Essence', 4, 1, 0, 9), -- GLC 300
('�lectrique', 0, 0, 0, 10); -- EQC 400
GO

-- Insertion des anciennes voitures disponibles
INSERT INTO Voitures.Voiture (Couleur, Prix, Kilometrage, Disponible, VersionID)
VALUES 
('Noir', 45000.00, 15000, 1, 1), -- AMG A35
('Blanc', 85000.00, 5000, 1, 2), -- AMG C63
('Gris', 120000.00, 10000, 0, 3), -- G63 AMG (non disponible)
('Bleu', 60000.00, 20000, 1, 4), -- E300
('Noir', 95000.00, 8000, 1, 5), -- S500

-- Insertion des nouvelles voitures disponibles
('Rouge', 35000.00, 10000, 1, 6), -- A180
('Gris', 40000.00, 15000, 1, 7), -- B200
('Blanc', 55000.00, 12000, 1, 8), -- GLA 250
('Argent', 67000.00, 8000, 1,9); -- glc 300
go 