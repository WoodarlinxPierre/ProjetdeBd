USE ConcessionaireMercedes;
GO

CREATE TABLE users.Utilisateur(
	UtilisateurID int IDENTITY(1,1),
	MpdHache varbinary(32) NOT NULL,
	MpdSel varbinary(16) NOT NULL,
	Email nvarchar(256) NOT NULL
	Constraint PK_Utilisateur_UtilisateurID PRIMARY KEY(UtilisateurID)
);

ALTER TABLE users.Utilisateur
ADD CONSTRAINT UC_Courriel UNIQUE (Email);
GO

CREATE PROCEDURE users.USP_CreerUtilisateur
	@Email nvarchar(256),
	@MotDePasse nvarchar(100)
AS
BEGIN
	-- Sel Aléatoire
	DECLARE @MdpSel varbinary(16) = CRYPT_GEN_RANDOM(16);
	-- Concaténation mdp et sel
	DECLARE @MdpEtSel nvarchar(116) = CONCAT(@MotDePasse, @MdpSel);
	-- Hachage du mot de passe
	DECLARE @MdpHachage varbinary(32) = HASHBYTES('SHA2_256', @MdpEtSel);
	-- Insertion dans la table Client
	INSERT INTO users.Utilisateur (Email, MpdHache, MpdSel)
	VALUES(@Email,@MdpHachage,@MdpSel)
END
GO
--------À modifier
CREATE PROCEDURE users.USP_AuthClient
	@Courriel nvarchar(50),
	@MotDePasse nvarchar(50)
AS
BEGIN
	DECLARE @Sel varbinary(16)
	DECLARE @MdpHache varbinary(32)
	SELECT @Sel = MpdSel, @MdpHache = MpdHache
	FROM users.Utilisateur
	WHERE Email = @Courriel

	IF HASHBYTES('SHA2_256', CONCAT(@MotDePasse, @Sel)) = @MdpHache
	BEGIN
		SELECT * FROM users.Utilisateur WHERE Email = @Courriel;
	END
	ELSE
	BEGIN
		SELECT TOP 0 * FROM users.Utilisateur;
	END
END
GO

EXEC  users.USP_CreerUtilisateur
@Email = 'test@test.com', @MotDePasse = '12345'
