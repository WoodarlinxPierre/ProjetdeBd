USE ProjetFinalBdLeMans_2037266;
GO

 --Insérer des modèles de voitures emblématiques
INSERT INTO ref.Modele (AnneeConception, VitesseMax, Transmission, Motorisation) VALUES
(1969, 385, 'Manuelle', 'Essence'),  
(2000, 350, 'Automatique', 'Essence'), 
(2016, 340, 'Hybride', 'Hybride'),     
(2021, 320, 'Automatique', 'Essence'), 
(1995, 380, 'Manuelle', 'Essence'),
(1997, 360, 'Manuelle', 'Essence'),  --TWR Porsche WSC95
(2000, 350, 'Automatique', 'Essence'),  --Audi R8 LMP
(2003, 340, 'Automatique', 'Essence'),  --Bentley Speed 8
(2008, 330, 'Hybride', 'Diesel'),  --Audi R10 TDI
(2013, 320, 'Automatique', 'Hybride');  --Audi R18 etron quattro

 --Insérer des voitures spécifiques
INSERT INTO racing.Voiture ( Nom, ModeleID) VALUES
('Porsche 917', 1),
('Audi R8 LMP', 2),
('Toyota TS050 Hybrid', 3),
('Alpine A480', 4),
('McLaren F1 GTR', 5),
('TWR Porsche WSC95', 6),
('Audi R8 LMP', 7),
('Bentley Speed 8', 8),
('Audi R10 TDI', 9),
( 'Audi R18 etron quattro', 10);

 --Insérer des conducteurs célèbres
INSERT INTO racing.Conducteur ( Nom, Prenom, DateNaissance, PaysOrigine, NombreVictoires) VALUES
( 'Kristensen', 'Tom', '19670707', 'Danemark', 9),
( 'Ickx', 'Jacky', '19450101', 'Belgique', 6),
( 'Foyt', 'A.J.', '19350116', 'USA', 1),
( 'Negrao', 'André', '19920617', 'Brésil', 1),
( 'Dalmas', 'Yannick', '19610728', 'France', 4),
( 'Dindo', 'Capello', '19640617', 'Italie', 3),
( 'Pirro', 'Emanuele', '19620112', 'Italie', 5),
( 'Biela', 'Frank', '19640802', 'Allemagne', 5);

 --Insérer des écuries mythiques
INSERT INTO racing.Ecurie ( Nom, DateIntegration, PaysOrigine, NombreVictoires, ConducteurID, VoitureID) VALUES
( 'Porsche', '19510623', 'Allemagne', 19, 1, 1),
( 'Audi Sport Team Joest', '19990601', 'Allemagne', 13, 2, 2),
( 'Toyota Gazoo Racing', '20120616', 'Japon', 5, 3, 3),
( 'Alpine Elf Matmut', '20210601', 'France', 1, 4, 4),
( 'McLaren', '19950617', 'RoyaumeUni', 1, 5, 5);

INSERT INTO racing.Champion ( Annee, ModeleVoitureGagnante, ConducteurID, EcurieID) VALUES
(1971, 'Porsche 917', 1, 1),
(2000, 'Audi R8 LMP', 2, 2),
(2018, 'Toyota TS050 Hybrid', 3, 3),   --Toyota gagne en 2018
(2021, 'Alpine A480', 4, 4),           --Alpine gagne en 2021
(1995, 'McLaren F1 GTR', 5, 5),
--Tom Kristensen (9 victoires)
(1997, 'TWR Porsche WSC95', 1, 1),
(2000, 'Audi R8 LMP', 1, 2),
(2001, 'Audi R8 LMP', 1, 2),
(2002, 'Audi R8 LMP', 1, 2),
( 2003, 'Bentley Speed 8', 1, 2),
( 2004, 'Audi R8 LMP', 1, 2),
( 2005, 'Audi R8 LMP', 1, 2),
( 2008, 'Audi R10 TDI', 1, 2),
( 2013, 'Audi R18 etron quattro', 1, 2),

 --Jacky Ickx (6 victoires)
( 1969, 'Ford GT40', 2, 1),
( 1975, 'Mirage GR8', 2, 1),
( 1976, 'Porsche 936', 2, 1),
( 1977, 'Porsche 936', 2, 1),
( 1981, 'Porsche 936', 2, 1),
( 1982, 'Porsche 956', 2, 1),

 --A.J. Foyt (1 victoire déjà ajoutée en 1967)
( 1967, 'Ford GT40', 3, 1),

 --Yannick Dalmas (4 victoires)
( 1992, 'Peugeot 905', 5, 5),
( 1994, 'Dauer 962 Le Mans', 5, 5),
( 1995, 'McLaren F1 GTR', 5, 5),  
( 1999, 'BMW V12 LMR', 5, 5);
GO
 --Insérer des circuits
INSERT INTO ref.Circuit ( Nom, Longueur, NombreVirages) VALUES
( 'Circuit de la Sarthe', 13.626, 38);


 --Insérer toutes les courses gagnées par ces conducteurs
INSERT INTO racing.Course ( Nom, Date, Pays, CircuitID, ChampionID) VALUES
('24 Heures du Mans 1971', '19710613', 'France', 1, 1),
('24 Heures du Mans 2000', '20000618', 'France', 1, 2),
('24 Heures du Mans 2018', '20180617', 'France', 1, 3),   --Toyota gagne ici
('24 Heures du Mans 2021', '20210821', 'France', 1, 4),   --Alpine gagne ici
('24 Heures du Mans 1995', '19950618', 'France', 1, 5),
('24 Heures du Mans 1997', '19970615', 'France', 1, 6),
('24 Heures du Mans 2000', '20000618', 'France', 1, 7),
('24 Heures du Mans 2001', '20010617', 'France', 1, 8),
('24 Heures du Mans 2002', '20020616', 'France', 1, 9),
( '24 Heures du Mans 2003', '20030615', 'France', 1, 10),
( '24 Heures du Mans 2004', '20040613', 'France', 1, 11),
( '24 Heures du Mans 2005', '20050619', 'France', 1, 12),
( '24 Heures du Mans 2008', '20080615', 'France', 1, 13),
( '24 Heures du Mans 2013', '20130623', 'France', 1, 14),

( '24 Heures du Mans 1969', '19690615', 'France', 1, 15),
( '24 Heures du Mans 1975', '19750615', 'France', 1, 16),
( '24 Heures du Mans 1976', '19760613', 'France', 1, 17),
( '24 Heures du Mans 1977', '19770612', 'France', 1, 18),
( '24 Heures du Mans 1981', '19800614', 'France', 1, 19),
( '24 Heures du Mans 1982', '19820620', 'France', 1, 20),

( '24 Heures du Mans 1967', '19670611', 'France', 1, 21),

( '24 Heures du Mans 1992', '19920621', 'France', 1, 22),
( '24 Heures du Mans 1994', '19940619', 'France', 1, 23),
( '24 Heures du Mans 1995', '19950618', 'France', 1, 24), 
( '24 Heures du Mans 1999', '19990620', 'France', 1, 25);

GO
