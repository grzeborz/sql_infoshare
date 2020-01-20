--
drop table if exists kniga
Create table kniga (
knigaid int identity (1,1) not null primary key,
tytul text
);

insert into kniga (tytul) values ('Lot nad kukulczym gniazdem'),
								('tarzan'),
								('pory pomidory'),
								('matrix')

drop table if exists klientksiazki;
create table klientksiazki(
klientid int identity (1,1) not null primary key,
klientMeno nvarchar(50) not null,
punkty int,
knigaid int foreign key references kniga(knigaid)
);

--Tworzymy dwie tabelki Klient i Ksiazka



drop procedure if exists klientWyPozycz;
go
create procedure klientWyPozycz (@ksiazkaid int, @klientdelikwent nvarchar(50))
as
	Begin
		if not exists
			(
			select 1 from klientksiazki
				where klientMeno = @klientdelikwent
			)
			begin
				insert into klientksiazki (klientMeno, knigaid, punkty)
					values (@klientdelikwent, @ksiazkaid, 1)
			end
		else 
			begin
				update klientksiazki 
				set knigaid = @ksiazkaid, punkty = (punkty+1)
				where klientMeno = @klientdelikwent
			end
	END

go
exec dbo.klientWyPozycz  @ksiazkaid = 3, @klientdelikwent = 'marek'

select *
from klientksiazki
--Ksiazke mozna przypopisac do klienta
--Klient ma pole punkty
--przy wypozyczeniu dostaje 1 punkt
--nalezy napisac procedure ktora wypozycza ksiazke biorac ksiazkaId i klientId