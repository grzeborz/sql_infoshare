
declare @nazwaTabeli nvarchar(100) = 'Prod'
declare @sql nvarchar(100) = 'create table '+convert(nvarchar(100),@nazwaTabeli)+'(id int)'
execute( @sql)

select * from Prod;

--declare cursorRok cursor for
--	select distinct YEAR(OrderDate) from Orders 
--​
--open cursorRok 
--​
--declare @year int
--fetch from cursorRok into @year
--while @@FETCH_STATUS = 0
--begin
--	declare @sqlCommad nvarchar(300) = 'create table Przychod_' + convert(nvarchar(4), @year) + 
--	      '(miesiac int, rok int, przychod money)'
--	execute (@sqlCommad)
--	fetch from cursorRok into @year
--end
--close cursorRok 
--deallocate cursorRok

go
declare kursorRok cursor for
		select distinct YEAR(OrderDate) from Orders
open kursorRok

declare @year int
fetch from kursorRok into @year
while @@FETCH_STATUS = 0

begin
	declare @nazwaTabeli nvarchar(20) = 'Przychod_'+ convert(nvarchar(4), @year) 
	--declare @sql nvarchar(300) = 'create table Przychod_'+Convert(nvarchar(4), @year)+
	--'(mieisiac int, rok int, przychod money')
	declare @sqlCommad nvarchar(300) = 'create table Przychod_' + @nazwaTabeli+ 
	      '(miesiac int, rok int, przychod money)'
	execute (@sqlCommad)

	declare @miesiac int = 1;

	while (@miesiac <=12)
		begin 

			declare @przychod money
			set @przychod = (select top 1
			SUM(Quantity*UnitPrice*(1-Discount)) as kosztFakturki
			from Orders o left join [Order Details] od on o.OrderID = od.OrderID
			where MONTH(OrderDate)=@miesiac and YEAR(OrderDate) = @year
			group by month(orderdate),year(orderdate), o.OrderID
			)
			declare @insertSql = 'insert into '+@nazwaTabeli '(miesiac, rok, przychod) values ('
			+convert(nvarchar(5), @miseiac)+','+convert(nvarchar(4), @year)+','+
			convert(nvarchar(20),@przychod)+')'

			exceute (@insertSql)
			set @miesiac = @miesiac +1
		end

	fetch from kursorRok into @year
end

close kursorRok
deallocate kursorRok;


with dochody (miesiac,rok,zamID,suma)as(
select month(orderdate), year(orderdate),o.OrderID,
			SUM(Quantity*UnitPrice*(1-Discount)) as kosztFakturki
from Orders o left join [Order Details] od on o.OrderID = od.OrderID
group by month(orderdate),year(orderdate), o.OrderID
)
select * from dochody

--use northwind
--go
--drop table if exists tabelaFakturowa;
--create table tabelaFakturowa
--(
--id int,
--mies int,
--rok int,
--orderid int primary key not null,
--lacznaCenaZamowienia money not null
--)

--select * from tabelaFakturowa;

--declare populationoftheTaxTable cursor for
--					select ROW_NUMBER() over
--							(partition by year(orderdate), month(orderdate) 
--							order by year(orderdate), month(orderdate)) as Nr,
--							 month(orderdate), year(orderdate),o.OrderID,
--							 SUM(Quantity*UnitPrice*(1-Discount)) as kosztFakturki
--					from Orders o left join [Order Details] od on o.OrderID = od.OrderID
--					group by month(orderdate),year(orderdate), o.OrderID--, SUM(Quantity*UnitPrice)

--					declare @Nr int, @orderID int, @miesiac int, @rok int, @wartosc money

--					open populationoftheTaxTable

--					fetch from populationoftheTaxTable into @Nr, @miesiac, @rok,@orderID, @wartosc

--					while @@FETCH_STATUS = 0

--						begin
--							insert into tabelaFakturowa (id ,mies,rok,orderid,lacznaCenaZamowienia)
--										values(@Nr, @miesiac,@rok, @orderID, @wartosc)
--							--update tabelaFakturowa set id = @Nr, 
--							--						mies = @miesiac, 
--							--						rok = rok,
--							--						orderid = @orderID,
--							--						lacznaCenaZamowienia = @wartosc
--							fetch from populationoftheTaxTable into @Nr, @miesiac, @rok,@orderID, @wartosc
--						end
--					close populationoftheTaxTable
--				deallocate populationoftheTaxTable

--select * from tabelaFakturowa;

--					--select * from Orders o left join [Order Details] od on o.OrderID = od.OrderID



