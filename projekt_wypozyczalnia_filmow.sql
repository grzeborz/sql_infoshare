﻿/******************************
** File: projekt_wypozyczalnia_filmow.sql
** Name: Movie Rental Project
** Desc: DDL + DML dotyczący projektu wypozyczlani.
Składa się z tabel: 
** Auth: Grzegorz Sz.
** Date: 2020-01-18
**************************
** Change History
**************************
** PR   Date        Author  Description 
** --   --------   -------   ------------------------------------
** 1    2020/01/18  Grzechu     initial creation
*******************************/

--SELECT CURRENT_USER;  
--GO
declare @current_user nvarchar(20) = (SELECT CURRENT_USER)
print @current_user
use Northwind;
go
drop schema if exists mrp;
go
CREATE SCHEMA mrp AUTHORIZATION dbo;
GO

--Tworzę tabelę filmy
drop table if exists moviesType;
Create table Northwind.mrp.moviesType
(
MovieTypeId  int identity(1,1) NOT NULL primary key,
MovieType nvarchar(15) not null,
);
drop table if exists Northwind.mrp.movies;
Create table Northwind.mrp.movies
(
MovieId int identity(1,1) NOT NULL primary key,
Title nvarchar(50) not null,
MovieTypeId int foreign key references mrp.moviesType(MovieTypeId)
);
drop table if exists Northwind.mrp.Clients;
Create table Northwind.mrp.Clients
(
ClientId  int identity(1,1) NOT NULL primary key,
ClientName ntext,
ClientSurname ntext,
BonusPoints int
);

drop table if exists Northwind.mrp.ClientsOrders;
Create table Northwind.mrp.ClientsOrders
(
OrderId int identity(1,1) NOT NULL primary key,
ClientId int foreign key references mrp.Clients(ClientId),
MovieId int foreign key references mrp.movies(MovieId),
DateStart date not null,
DateEnd date not null,
);

insert into mrp.moviesType(MovieType) 
		values ('nowy'),
				('zwykly'),
				('stary')

insert into mrp.movies(Title, MovieTypeId) 
		values ('Matrix 11', 1),
				('Spider Man', 2),
				('Spider Man 2', 2),
				('Out of Africa', 3)

insert into mrp.Clients(ClientName, ClientSurname) 
		values ('Marian', 'Pazdzioch'),
				('Stachu', 'Kowalski'),
				('Zdzislaw', 'Nowak'),
				('Janusz', 'Koniecpolski')


select *
	from Northwind.mrp.ClientsOrders

	update northwind.mrp.ClientsOrders set ClientId = 2 where MovieId = 1

--do edycji procedura
drop procedure if exists klientWypozyczylFilm;
go
create procedure klientWypozyczylFilm(@filmId int, @KlientId int)
as
begin
	begin try
		if not exists (select 1 from northwind.mrp.Clients k where k.ClientId = @KlientId)
			raiserror('klient %d nie istnieje', 16, 1, @KlientId)
				begin
				--print 'klient nie istnieje, id - ' + convert(nvarchar(5), @klientId);
				if exists (select 1 from northwind.mrp.movies k where k.MovieId = @filmId)
					begin
						declare @wypKlientId int;
						set @wypKlientId = (select top 1 ClientId from northwind.mrp.ClientsOrders where MovieId = @filmId)
						if (@wypKlientId is null)
							begin
								update northwind.mrp.ClientsOrders set ClientId = @KlientId where MovieId = @filmId
								update northwind.mrp.Clients set BonusPoints = BonusPoints + 1 where ClientId = @KlientId
								print 'OK'
							end
						else
							raiserror('Film wypozyczony klientowi o id %d', 16, 1, @wypKlientId)
						--begin
						--	print 'Ksiazka wypozyczona klientowi o id ' + convert(nvarchar(5), @wypKlientId)
						--end
					end
				else
					raiserror('Film nie istnieje, id -  %d ', 15, 3, @filmId)
				--begin
				--	print 'ksiazka nie istnieje, id - ' + convert(nvarchar(5), @ksiazkaId);
				end
	end try
	begin catch
		if (@@TRANCOUNT > 0) 
		begin
			rollback
			print 'rollback'
		end
		declare @msg nvarchar(100) = error_message();
		declare @state int = error_state()
		declare @error_severity int = error_severity()	
		raiserror(@msg, @error_severity, @state)
	end catch
	if (@@TRANCOUNT > 0)
		commit
end


go
exec dbo.klientWypozyczylFilm  @filmid = 1, @klientid =1

--drop procedure if exists podsumowanieKlienta;
--go
--create procedure podsumowanieKlienta()

--insert into 
--Matrix 11 (nowy) 1 days 40 PLN
--Spider Man (zwykły) 5 days 90 PLN
--Spider Man 2 (zwykły) 2 days 30 PLN
--Out of Africa (stary) 7 days 90 PLN
--spóźnione
--Matrix 11 (nowy) 2 extra days 80 PLN
--Spider Man (zwykły) 1 days 30 PLN