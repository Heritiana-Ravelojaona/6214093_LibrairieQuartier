-- Création de la base de données
--Creation de la BD

USE MASTER 
GO

CREATE DATABASE LibrairieQuartier
GO
USE LibrairieQuartier
GO

EXEC sp_configure filestream_access_level, 2 RECONFIGURE

ALTER DATABASE LibrairieQuartier
ADD FILEGROUP FG_Images CONTAINS FILESTREAM;
GO
ALTER DATABASE LibrairieQuartier
ADD FILE (
	NAME = FG_Images,
	FILENAME = 'C:\EspaceLabo\FG_Images_6214093'
)
TO FILEGROUP FG_Images
GO
