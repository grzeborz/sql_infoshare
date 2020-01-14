--Stworzyć tabele Klient z polami:
--KlientID które ma być się inkrementować automatycznie
--Tekstowymi Imię i Nazwisko
--Pesel. Unikalne pole z walidacja – 9 cyfr

drop table northwind.dbo.Klient;
Create table northwind.dbo.Klient
(
KlientID int identity(1,1) NOT NULL primary key,
Imie ntext NOT NULL,
Naziwsko ntext NOT NULL,
dataDodania smalldatetime default getdate(),
Pesel nvarchar (11) unique
);
--dodajemy ograniczneia poprzez altertable by nie przeszły złe dane do tabeli
alter table northwind.dbo.Klient
	add constraint CN_KlientPoprawnyPesel
		check
		(Pesel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
alter table northwind.dbo.Klient
	add constraint CN_KlientPoprawnaData
		check
		(dataDodania <= getdate())

--dodajemy dane 
insert into northwind.dbo.Klient values ('Marian', 'Pazdzioch', getdate(), '12345678912'),
('Zdzichu', 'Kaosz', getdate(), '12345678666'),
('Stefan', 'Kupa', getdate(), '66665678912'),
('Mirek', 'Kapusta', getdate(), '16645678912');

use Northwind
go
select *
from Klient;
--Wywali błąd bo jet w sprawdzeniu zła wartość - nie unikalny PESEL
insert into northwind.dbo.Klient values ('Zdzichu', 'Kaosz', getdate(), '12345678912')

--Funkcja do sprawdzenia ograniczeń na tabeli
Exec sp_helpconstraint Klient

