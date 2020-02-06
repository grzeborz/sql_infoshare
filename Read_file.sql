Use Northwind
go
drop table if exists Sprzedaz;
create table Sprzedaz(
id int identity(1,1),
Klient int,
Kwota money,
Pracownik int,
Czas datetime
);


BULK INSERT Sprzedaz
FROM 'C:\Users\grzegorz.szyperek\Documents\SQL Server Management Studio\sprzedaz.csv'
WITH (FIELDTERMINATOR = ';',
MAXERRORS = 0, 
ROWTERMINATOR = '\n',
FIRSTROW = 2);

select *
	from Sprzedaz;
