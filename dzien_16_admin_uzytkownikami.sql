DROP LOGIN  Pirat13;
USE master

GO

CREATE LOGIN Pirat13 
	WITH PASSWORD = '32157SDDGADSGfrewferwf#$%$#^%', 	DEFAULT_DATABASE=[Northwind], 
          CHECK_EXPIRATION=OFF, CHECK_POLICY=off



USE Northwind
        
CREATE USER Pirat13User FOR LOGIN Pirat13;

EXEC sp_addrolemember 'db_owner', Pirat13User


GRANT SELECT to Pirat13User

DENY SELECT on ORDERS to Pirat13User

GRANT CREATE TABLE to Pirat13User

GRANT SELECT, INSERT, UPDATE 
	ON ORDERS TO Pirat13User

