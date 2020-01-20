
drop table if exists tablicaMnozenia;
create table tablicaMnozenia
(
id int identity (1,1) primary key,
liczba1 int,
liczba2 int,
wynikmnozenia int
)

select *
	from tablicaMnozenia;

insert into tablicaMnozenia (liczba1, liczba2) values (2,2);


drop function if exists pomnoz;
go
create function pomnoz(@arg1 int, @arg2 int)
returns int
as 
	begin
		return @arg1 * @arg2
	end

go
declare @wynik int
set @wynik = dbo.pomnoz(2,2)
print @wynik

go
select liczba1, liczba2, dbo.pomnoz(liczba1, liczba2) as wynikmnozenia from tablicaMnozenia

go
update tablicaMnozenia set wynikmnozenia = dbo.pomnoz(liczba1, liczba2)

/*********************************
--czego nie wolno robić w funkcji :
funkcja nie może mieć skutków ubocznych np. polecenia inset lub update
--roznia miedzy funkcja a procedura - funkcja musi zwracać wartość a procedura nie

-- procedury nie można używać w selektach czy li w zapytaniach
--ale zapytanie może updateować i insertować dane w tabelach
*********************************/


drop function if exists dbo.dodawanie;
go
create function dodawanie(@arg1 int, @arg2 int)
returns int
begin
	return @arg1 + @arg2
end

go
select dbo.dodawanie(dbo.pomnoz(2,2), dbo.pomnoz(2,5))


---zagniezdzona funkcja

drop function if exists sumakwadratow;
go
create function sumakwadratow(@arg1 int, @arg2 int)
returns int
as
	BEGIN
		declare @kwadraArg1 int = dbo.pomnoz(@arg1, @arg1)
		declare @kwadraArg2 int = dbo.pomnoz(@arg2, @arg2)
		return dbo.dodawanie(@kwadraArg1, @kwadraArg2)
	END

	go
select dbo.sumakwadratow(2,3)


----Zadanko na stworzenie tabelek
use Northwind
drop table if exists TypProduktu;
go
create table TypProduktu
(
TypId int identity (1,1) primary key,
StawkaVat float
)
drop table if exists Product;
use Northwind
go
create table Product
(
ID int identity (1,1) primary key,
CENA money,
CenaBrutto money,
TypId int foreign key references TypProduktu(TypId)
);

insert into TypProduktu (StawkaVat) 
values
(23.00),
(15.00),
(21.50)
select * from TypProduktu;

insert into Product (CENA,TypId) 
values
(90, 1),
(20, 2),
(5, 1),
(12, 3),
(50, 2)

drop function if exists stawkaVat;
go
create function stawkaVat(@typId int)
returns float
	as
	begin
		declare @wynik float
		set @wynik = (select top 1 stawkaVat from TypProduktu where TypId = @typId)
		return @wynik
	end

update Product set CenaBrutto = (CENA * dbo.stawkaVat(TypId))/100
select * from Product


--create procedure obliczenie_ceny_brutto (@typ)

--update Product set CenaBrutto = (CENA * dbo.stawkaVat(TypId))/100


select * from INFORMATION_SCHEMA.TABLES

--sprawdzamy czy tabelka istnieje
drop procedure if exists stworzTabele;
go
create procedure stworzTabele--(@nazwaTabeli text, @zawartoscLogu nvarchar(200))
as
BeGIN
	if not exists
		(select 1
			from INFORMATION_SCHEMA.TABLES
			where TABLE_CATALOG = 'Northwind'
				and TABLE_SCHEMA = 'dbo'
				and TABLE_NAME = 'DbLog')
				begin
					--drop table if exists Dblog;
					--declare @wiadomosc nvarchar(200) = @zawartoscLogu
					create table DbLog (
					id int identity(1,1) primary key,
					logMessage nvarchar(200),
					czas datetime2
					)
					--insert into DbLog (logMessage, czas) values (@wiadomosc, GETDATE());
				end
	--else 
		--begin
		--	insert into DbLog (logMessage, czas) values (@wiadomosc, GETDATE());
		--end
END

drop procedure if exists loguj;
go
create procedure loguj(@message nvarchar(200))
as
	begin
		exec dbo.stworzTabele
		insert into DbLog(logMessage, czas) values (@message, GETDATE())
	end

exec loguj @message = 'Super huper'

select * from DbLog
