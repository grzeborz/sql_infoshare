--create table esssssss
--(id int identity(1,1),
--nazwa nvarchar(10) check (nazwa like '[a-z]')
--);

--begin try
--insert into esssssss (nazwa) values ('1234')


--begin try


--kontoID, saldo
use Northwind
go
create table burzuje
(
KontoId int identity(1,1),
Kwota money not null
);

insert into burzuje (kwota)values(100),(0);

select *
	from burzuje;

use Northwind
go
drop procedure if exists przelejhajsiwo;
go
create procedure przelejhajsiwo(@konto1 int, @konto2 int, @kwotadoprzelania money)
as
begin --transaction
	declare @klient1 int = (select KontoId from burzuje where KontoId=@konto1)
	declare @klient2 int = (select KontoId from burzuje where KontoId=@konto2)
	begin try
		if @klient1 is null or @klient1 = @konto2
			raiserror ('Klient %d nie został zarejestrowany w banku.', 16, 1, @konto1)

		if  @klient2 is null or @konto2 = @klient1
			raiserror ('Klient %d nie został zarejestrowany w banku.', 16, 1, @konto2)

		if @kwotadoprzelania < (select Kwota from burzuje where KontoId=@konto1)
			raiserror ('Klient %d nie posiada wystarczajacych srodkow na koncie.', 16, 1, @konto1)

		Update 
	end try 
	begin catch
		print 'Yoł Elo'
	end catch

end




go
exec northwind.dbo.przelejhajsiwo  @konto1 = 2, @konto2 =2, @kwotadoprzelania = 100