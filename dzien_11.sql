
----dodawanie danych za pomocą procedury
--create procedure addProduct(
--				@productName nvarchar(20),
--				@categoryName nvarchar(20)
--       )
--as
--begin
--	declare @categoryId int;
--	set @categoryId =
--	    (select c.categoryId from Categories c where c.CategoryName = @categoryName)
--	if (@categoryId is null)
--	begin
--		print 'No category, inserting a new one'
--		insert into Categories(CategoryName) values (@categoryName)
--	end
--	set @categoryId =
--	    (select c.categoryId from Categories c where c.CategoryName = @categoryName)
--	insert into Products (ProductName, CategoryID) values (@productName, @categoryId)
--end

--zadanko ---
-- tabela ORDErs - usunąć zamówienia starsze niż podane - dwa argumenty - rok i miesiąc

--create procedure removeOrders(
--				@Year INT(4),
--				@Month INT(2)
--       )
--as
--begin
--	if ((select orderID, YEAR(OrderDate), MONTH(OrderDate)
--			from Orders 
--				where  exists (select orderID, YEAR(OrderDate), MONTH(OrderDate)
--								from Orders YEAR(OrderDate) < @Year and MONTH(OrderDate) < @Month))) is null)
--		begin
--			print 'No category, inserting a new one'
--		end
--	eLSE
--		DELETE from Orders 
--				where  YEAR(OrderDate) < @Year and MONTH(OrderDate) < @Month

--end

--exec removeOrders 2017 2
--lub
--exec removeOrders @Year = 2017 @Month=2

--select orderID, YEAR(OrderDate), MONTH(OrderDate)
--from Orders 
--where  YEAR(OrderDate) < 2000 and MONTH(OrderDate) < 1

--go
--create procedure lowePriceForCategory
--	(@categoryName


---ZADANIE 3 ---
--Tabele: Categories, Products, [Order Details]
--Napisać procedurę która Obniży cenę UnitPrice o ilość procent przekazaną jako argument dla wszystkich produktów 
--lub dla podanej kategorii produktów

--drop procedure if exists ObnizycCeneOProcent
--go
--create procedure ObnizycCeneOProcent(@Procent nvarchar(3), @Kategoria int = null )
--as
--BeGIN
--	print 'ObnizycCeneOProcent'
--	print @Procent
--	print @Kategoria
--	if @Kategoria is null
--		select (od.UnitPrice*@Procent/100) as UnitPricePoObnizce,od.UnitPrice, c.CategoryID
--			from Categories c
--				left join  Products p on c.CategoryID = p.CategoryID
--				left join [Order Details] od on od.ProductID=p.ProductID
--	else
--		select (od.UnitPrice*@Procent/100) as UnitPricePoObnizce,od.UnitPrice, c.CategoryID
--			from Categories c
--				left join  Products p on c.CategoryID = p.CategoryID
--				left join [Order Details] od on od.ProductID=p.ProductID
--				where c.CategoryID = @Kategoria
--END

--exec ObnizycCeneOProcent @Procent = 50, @Kategoria = 2


---ZADANIE 5---
--Napisać procedurę która będzie obniżać cenę aż średnia cena będzie mniejsza od podanej jako argument
drop procedure if exists ObnizycCeneSredniaOArgument
go
create procedure ObnizycCeneSredniaOArgument(@ArgumentObnizajacy float)
as
BeGIN
	print 'ArgumentObnizajacy'
	print @ArgumentObnizajacy
	declare @Procent float = 1
	declare @sredniaCena float = (select AVG(unitprice) from [Order Details])
	while @sredniaCena >= @ArgumentObnizajacy
		--print @sredniaCena

		begin
			print @Procent
			set @sredniaCena = (select AVG(UnitPrice-(UnitPrice*@Procent/100)) from [Order Details])
			print @sredniaCena
			print @Procent
			set @Procent = @Procent + 1
		end
		print @Procent
END

exec ObnizycCeneSredniaOArgument 10