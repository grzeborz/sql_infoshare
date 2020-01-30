/******************************
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
--declare @current_user nvarchar(20) = (SELECT CURRENT_USER)
--print @current_user
--use Northwind;
--go
--drop schema if exists mrp;
--go
--CREATE SCHEMA mrp AUTHORIZATION dbo;
--GO

--Tworzę tabelę filmy
use Northwind
go
drop table if exists moviesType;
Create table moviesType
(
MovieTypeId  int identity(1,1) NOT NULL primary key,
MovieType nvarchar(15) not null,
);
use Northwind
go
drop table if exists movies;
Create table movies
(
MovieId int identity(1,1) NOT NULL primary key,
Title nvarchar(50) not null,
MovieTypeId int foreign key references moviesType(MovieTypeId)
);
use Northwind
go
drop table if exists Clients;
Create table Clients
(
ClientId  int identity(1,1) NOT NULL primary key,
ClientName ntext,
ClientSurname ntext,
BonusPoints int default 0
);
use Northwind
go
drop table if exists ClientsOrders;
Create table ClientsOrders
(
OrderId int identity(1,1) NOT NULL primary key,
ClientId int foreign key references Clients(ClientId),
MovieId int foreign key references movies(MovieId),
DateStart date not null,
DateEnd date not null,
Koszt money,
KosztOpoznienia money
);

insert into moviesType(MovieType) 
		values ('nowy'),
				('zwykly'),
				('stary')

insert into movies(Title, MovieTypeId) 
		values ('Matrix 11', 1),
				('Spider Man', 2),
				('Spider Man 2', 2),
				('Out of Africa', 3)

insert into Clients(ClientName, ClientSurname) 
		values ('Marian', 'Pazdzioch'),
				('Stachu', 'Kowalski'),
				('Zdzislaw', 'Nowak'),
				('Janusz', 'Koniecpolski')

use Northwind
go
select *
	from Clients

use Northwind
go
select *
	from ClientsOrders 

--update Clients set ClientName = 'Marian' where ClientId = 1

--update ClientsOrders set DateStart='2020-10-12', DateEnd ='2020-10-12'-- where MovieId = 1

--do edycji procedura
drop procedure if exists klientWypozyczylFilm;
go
create procedure klientWypozyczylFilm(@filmId int, @KlientId int, @iloscDni int)
as
begin
	begin try
		if not exists (select 1 from Clients k where k.ClientId = @KlientId)
			raiserror('Klient %d nie został zarejestrowany w bazie.', 16, 1, @KlientId)
				begin
				if exists (select 1 from movies k where k.MovieId = @filmId)
					begin
						declare @wypKlientId int;
						set @wypKlientId = (select top 1 ClientId from ClientsOrders where MovieId = @filmId)
						if (@wypKlientId is null)
							begin
								declare @kosztfilmu money, convert(money, @start date = GETDATE(), @koniec date = GETDATE()+ @iloscDni, @roznicadni int;
								set @kosztfilmu = (select case
																		when m.MovieTypeId = 1 then 40 * @roznicadni
																		when m.MovieTypeId = 2 and @roznicadni <= 3 then @roznicadni * 10
																		when m.MovieTypeId = 2 and @roznicadni > 3 then 30 + (@roznicadni - 3)*30
																		when m.MovieTypeId = 3 and @roznicadni <= 5 then @roznicadni * 30
																		when m.MovieTypeId = 3 and @roznicadni > 5 then 30 + (@roznicadni - 5)*30
																	end)
																from movies m 
																left join moviesType mt 
																on m.MovieTypeId = mt.MovieTypeId
																where MovieId = @filmId)
								print @kosztfilmu
								insert into ClientsOrders (ClientId, MovieId, DateStart, DateEnd, Koszt) values (@KlientId, @filmid, @start, @koniec,@kosztfilmu)  --where MovieId = @filmId
								update Clients set BonusPoints = BonusPoints + 1 where ClientId = @KlientId	
							end
						else
							declare @dataZwrotu nvarchar(20) = (select CAST(DateEnd as nvarchar(20)) from ClientsOrders where MovieId = @filmId)
							begin
								raiserror('Film został wypozyczony klientowi o id %d zostanie zwrócony %s, Zapraszamy ponownie.', 16, 1, @wypKlientId, @dataZwrotu)
							end
						--begin
						--	print 'Ksiazka wypozyczona klientowi o id ' + convert(nvarchar(5), @wypKlientId)
						--end
					end
				else
					raiserror('Film nie istnieje w bazie, id -  %d ', 15, 3, @filmId)
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
exec northwind.dbo.klientWypozyczylFilm  @filmid = 2, @klientid =2, @iloscDni = 6

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

select convert(int,datediff(day,GETDATE(),GETDATE()+2))