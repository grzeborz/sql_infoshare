--Stworzyć tabele Ksiązka z polami:
--KsiazkaID które ma być się inkrementować automatycznie
--Tytuł - tekstowe
--KlientID, które jest kluczem obcym wskazującym na tabele Klient

--W następnym kroku należy dodać usuwanie kaskadowe i je przetestować


--Create table northwind.dbo.Ksiazka
--(
--KsiazkaID int identity(1,1) NOT NULL,
--Tytul ntext NOT NULL,
--KlientID int NOT NULL,
--);

--alter table northwind.dbo.Ksiazka 
--	add constraint FK_IdKlientaKsiazki
--		foreign key (KlientID) references Klient(KlientID);

--insert into northwind.dbo.Ksiazka (Tytul, KlientID) values('Lot nad kukulczym gniazdem', 5)

--select *
--	from Ksiazka

--alter table Ksiazka
--	add constraint FKProductCategory
--		foreign key (KlientID) 
--		references Klient(KlientID)
--		on delete cascade;

--delete from Ksiazka
--	where KlientID = 5
drop table if exists northwind.dbo.Ksiazka;
Create table northwind.dbo.Ksiazka
(
KsiazkaID int identity(1,1) NOT NULL Primary Key,
Tytul ntext NOT NULL
);

Create table northwind.dbo.KlientKsiazka
(
KsiazkaID int NOT NULL,
KlientID int NOT NULL,
);

alter table northwind.dbo.KlientKsiazka
	add constraint FK_IdKsiazki
		foreign key (KsiazkaID) references Ksiazka(KsiazkaID);
alter table northwind.dbo.KlientKsiazka
	add constraint PK_IdKlienta
		foreign key (KlientID) references Klient(KlientID);

alter table KlientKsiazka
	add constraint FKKlientKsiazka
		foreign key (KlientID) 
		references Klient(KlientID)
		on delete cascade;

alter table KlientKsiazka
	add constraint FKKsiazkaKlient
		foreign key (KsiazkaID) 
		references Ksiazka(KsiazkaID)
		on delete cascade;

insert into northwind.dbo.Ksiazka (Tytul) 
values
('Lot nad kukulczym gniazdem'),
('Matrix'),
('Lot'),
('Samolot')


insert into northwind.dbo.KlientKsiazka (KlientID, KsiazkaID) 
values
(1, 1),
(2, 2),
(3, 1),
(4, 3)

use Northwind
go
select *
	from KlientKsiazka



delete from Ksiazka
	where KlientID = 2
