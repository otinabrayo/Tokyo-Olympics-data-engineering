Use Master;


IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Tokyo_Olympics')
BEGIN
	ALTER DATABASE Tokyo_Olympics SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE Tokyo_Olympics
END;


CREATE DATABASE Tokyo_Olympics;

GO

USE Tokyo_Olympics;

GO

CREATE SCHEMA bronze;

GO

CREATE SCHEMA silver;

GO 

CREATE SCHEMA gold;

GO 
