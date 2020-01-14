--select *
--	from Customers

--	go
--create procedure demo(@Region varchar(3))
--as
--BeGIN
--	print 'DEMO'
--	select * from Customers where Region = @Region
--END

--exec demo @Region = 'SP'

--exec demo


--select *
--	from Customers
--	go
--alter procedure demo(@Region varchar(3) = null)
--as
--BeGIN
--	print 'DEMO'
--	print @Region
--	if (@Region = NULL)
--		select * from Customers where Region is NULL
--	else
--		select * from Customers where Region = @Region
--END

--exec demo @Region = NULL

---ZADNKO---
--1. Napisać procedurę która wypiszę wszystkie produkty lub produkty z podania kategorią

select *
	from Products

drop procedure if exists WypiszProdukty
	go
create procedure WypiszProdukty(@Kategoria int = null)
as
BeGIN
	print 'WypiszProdukty'
	print @Kategoria
	if (@Kategoria is NULL)
		select * from Products
	else
		select * from Products where CategoryID = @Kategoria
END

exec WypiszProdukty @Kategoria = 2

---ZADANIE 2---
--Tabelka Employees
--Procedura, która wypisuje pracowników mieszkają w danym mieście lub wszystkich pracowników jeśli nie podamy miasta jako argumentu

select *
	from Employees
	go
alter procedure WypiszPracownikow(@Miasto nvarchar(20) = null)
as
BeGIN
	print 'WypiszPracownikow'
	print @Miasto
	if (@Miasto is NULL)
		select * from Employees
	else
		select * from Employees where City = @Miasto
END

exec WypiszPracownikow @Miasto = 'London'

---ZADANIE 3 ---
--Tabele: Categories, Products, [Order Details]
--Napisać procedurę która Obniży cenę UnitPrice o ilość procent przekazaną jako argument dla wszystkich produktów 
--lub dla podanej kategorii produktów

drop procedure if exists ObnizycCeneOProcent
go
create procedure ObnizycCeneOProcent(@Procent nvarchar(3), @Kategoria int = null )
as
BeGIN
	print 'ObnizycCeneOProcent'
	print @Procent
	print @Kategoria
	if @Kategoria is null
		select (od.UnitPrice*@Procent/100) as UnitPricePoObnizce,od.UnitPrice, c.CategoryID
			from Categories c
				left join  Products p on c.CategoryID = p.CategoryID
				left join [Order Details] od on od.ProductID=p.ProductID
	else
		select (od.UnitPrice*@Procent/100) as UnitPricePoObnizce,od.UnitPrice, c.CategoryID
			from Categories c
				left join  Products p on c.CategoryID = p.CategoryID
				left join [Order Details] od on od.ProductID=p.ProductID
				where c.CategoryID = @Kategoria
END

exec ObnizycCeneOProcent @Procent = 50, @Kategoria = 2