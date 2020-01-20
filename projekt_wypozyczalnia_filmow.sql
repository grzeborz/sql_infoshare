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

--Tworzę tabelę filmy
drop table if exists Northwind.mrp.moviesType;
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
MovieTypeId int foreign key references MovieTypeId(moviesType)
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
ClientId int foreign key references Clients(ClientId),
MovieId int foreign key references movies(MovieId),
DateStart date not null,
DateEnd date not null
);


insert into moviesType(movetype) values ('nowy'),
										('zwykly'),
										('stary')

insert into movies(Title, MovieTypeId) values ('Matrix 11', 1),
												('Spider Man', 2),
												('Spider Man 2', 2),
												('Out of Africa', 3)
drop procedure if exists klientWypozyczylFilm;
go
create procedure klientWypozyczylFilm()


drop procedure if exists podsumowanieKlienta;
go
create procedure podsumowanieKlienta()

insert into 
--Matrix 11 (nowy) 1 days 40 PLN
--Spider Man (zwykły) 5 days 90 PLN
--Spider Man 2 (zwykły) 2 days 30 PLN
--Out of Africa (stary) 7 days 90 PLN
--spóźnione
--Matrix 11 (nowy) 2 extra days 80 PLN
--Spider Man (zwykły) 1 days 30 PLN