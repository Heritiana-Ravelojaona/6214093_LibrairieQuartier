--Création des tables + contraintes de clé primaire 

USE LibrairieQuartier
GO

CREATE TABLE Livres.Auteur (
    AuteurID INT IDENTITY (1,1) NOT NULL,
    NomAuteur NVARCHAR(50) NOT NULL,
    PrenomAuteur NVARCHAR(50) NOT NULL,
    Alias VARCHAR(50) NULL,
    DateNaissance DATETIME NOT NULL,
    DateDeces DATETIME,
    CONSTRAINT PK_Auteur_AuteurID PRIMARY KEY (AuteurID)
);

CREATE TABLE Livres.Livre (
    LivreID INT IDENTITY (1,1) NOT NULL,
	AuteurID INT NOT NULL,
	CategorieID INT NOT NULL,
    Titre NVARCHAR (100) NOT NULL,
    Editeur NVARCHAR (50) NOT NULL,
    DateParution DATETIME NOT NULL,
    ISBN NVARCHAR (13) NOT NULL,
    PrixVente MONEY  NOT NULL,
    DateRecu DATETIME NOT NULL,
	CONSTRAINT PK_Livre_LivreID PRIMARY KEY (LivreID)
);

CREATE TABLE Livres.Categorie (
    CategorieID INT IDENTITY (1,1) NOT NULL,
    Categorie NVARCHAR (50) NOT NULL
	CONSTRAINT PK_Categorie_CategorieID PRIMARY KEY (CategorieID)
);

CREATE TABLE Clienteles.Client (
    ClientID INT IDENTITY (1,1) NOT NULL,
    NomClient NVARCHAR (50) NOT NULL,
    PrenomClient NVARCHAR (50) NOT NULL,
    Courriel NVARCHAR (100) NOT NULL,
    Telephone NVARCHAR (15) NULL,
    CONSTRAINT PK_Client_ClientID PRIMARY KEY (ClientID)
);

CREATE TABLE Clienteles.Achat (
    AchatID INT IDENTITY (1,1) NOT NULL,
    DateCommande DATETIME NOT NULL,
    DateLivraison DATETIME NOT NULL, 
	ClientID INT NOT NULL
	CONSTRAINT PK_Achat_AchatID PRIMARY KEY (AchatID)
);

CREATE TABLE Clienteles.AchatLivre (
    AchatLivreID INT IDENTITY (1,1),
	AchatID INT NOT NULL,
	LivreID INT NOT NULL,
    PrixVendu MONEY NOT NULL,
    Quantite INT NOT NULL,
	CONSTRAINT PK_AchatLivre_AchatLivreID  PRIMARY KEY (AchatLivreID)
);
GO

--Création des contraintes de clé étrangère 

ALTER TABLE Livres.Livre  ADD  CONSTRAINT FK_Livre_AuteurID FOREIGN KEY(AuteurID)
REFERENCES Livres.Auteur (AuteurID)
GO

ALTER TABLE Livres.Livre  ADD CONSTRAINT FK_Livre_CategorieID FOREIGN KEY(CategorieID )
REFERENCES Livres.Categorie (CategorieID)
GO

ALTER TABLE Clienteles.Achat  ADD CONSTRAINT FK_Achat_ClientID FOREIGN KEY(ClientID )
REFERENCES Clienteles.Client  (ClientID)
GO

ALTER TABLE Clienteles.AchatLivre  ADD CONSTRAINT FK_AchatLivre_AchatID FOREIGN KEY(AchatID )
REFERENCES Clienteles.Achat (AchatID)
GO

ALTER TABLE Clienteles.AchatLivre  ADD CONSTRAINT FK_AchatLivre_LivreID FOREIGN KEY(LivreID )
REFERENCES Livres.Livre (LivreID)
GO

--Création des autres contraintes 

ALTER TABLE Livres.Livre ADD CONSTRAINT UC_Livre_ISBN UNIQUE (ISBN)
GO

ALTER TABLE Clienteles.AchatLivre ADD CONSTRAINT CK_AchatLivre_Quantite CHECK (Quantite > 0)
GO

ALTER TABLE Livres.Auteur ADD CONSTRAINT CK_Auteur_DateNaissance CHECK (DateNaissance < GETDATE())
GO

ALTER TABLE Livres.Auteur ADD CONSTRAINT CK_Auteur_DateDeces CHECK (DateDeces IS NULL OR DateDeces < GETDATE())
GO

ALTER TABLE Livres.Livre ADD CONSTRAINT CK_Livre_PrixVente CHECK (PrixVente > 0)
GO

ALTER TABLE Clienteles.AchatLivre ADD CONSTRAINT CK_AchatLivre_PrixVendu CHECK (PrixVendu > 0)
GO

ALTER TABLE Clienteles.Achat ADD  CONSTRAINT DF_Achat_DateCommande  DEFAULT (GETDATE()) FOR DateCommande
GO

ALTER TABLE Clienteles.Achat ADD  CONSTRAINT DF_Achat_DateLivraison  DEFAULT(GETDATE()) FOR DateLivraison
GO

