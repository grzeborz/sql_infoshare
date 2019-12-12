--POWTÓRKA--

--use Northwind
--go
----select GETDATE() as data
--use Northwind
--go
--select datediff(day, GETDATE()-1, GETDATE())


--select LastName +' '+FirstName+ ' pracuje w firmie '+ cast(datediff(year, HireDate, GETDATE())as varchar) + ' lat. Natomiast pracownik jest w wieku '+cast(datediff(year, BirthDate, GETDATE())as varchar) + ' lat'
--	from Employees;

--select c.country, COUNT(1) as liczbawystapien
--	from Customers c
--		group by country
--			order by 2 desc

--zadnako ile jest klientów w każegj grupie wiekowej i by były posortowane po wieku i liczbie

--use Northwind
--go
--with wiek as (
--select --LastName, FirstName, 
--	datediff(year, BirthDate, GETDATE()) as wiek
--	from Employees
--	group by datediff(year, BirthDate, GETDATE())
--	)
--	select wiek/5 as wiek, COUNT(1), wiek
--		from wiek
--			group by wiek/5, wiek
--				order by 1 desc


--select 
--	year(BirthDate),
--	COUNT(1)
--	from Employees
--	where year(BirthDate)>1960
--	group by year(BirthDate)
--	having COUNT(1)>1
--	order by


---zadanko kolejne 

--Tabela Order Details, pogrupowac po productId i policzyć średnią quantity dla danego productId
--a) Nie brać do średniej produktów o UnitPrice < 10
--b) Odfiltrować z wyników zapytania produkty o średniej z quantity < 10

--select ProductID, 
--	COUNT(1) ilosc_referencja,
--	avg(Quantity) srednia_ilosc
--	from [Order Details]
--	group by ProductID

--select ProductID, 
--	COUNT(1) ilosc_referencja,
--	avg(Quantity) srednia_ilosc
--	from [Order Details]
--	where UnitPrice >= 10 
--	group by ProductID
--	having avg(Quantity)>10
--	order by 2 desc,3 desc

--- zadanko na case i ilość zamówień
--tabela Order Details

--wypisujemy wszystkie table plus policzona poleceniem case
--Jeśli wartość zamówienia jest > 100 wtedy 'Duza wartosc' w innym przypadku 'Mała wartość'
--wartość zamówienia to cena * ilość i odjęta zniżka

--use Northwind
--go
--select orderid, productid,
--	case
--		when (UnitPrice*Quantity*(1-Discount)) > 100 then 'Fura forsy'
--		else 'Malo forsy'
--	end as Klasa_zamowienia
--	from [Order Details]


-----JOINY----
--left
--select *
--	from Products p
--		left join Categories c on p.CategoryID = c.CategoryID

--inner

--select *, coalesce(ProductName, 'superhuper')
--	from Categories c 
--		left join Products p on p.CategoryID = c.CategoryID


--ile jest produktów w kategorii

--select COUNT(1) liczba_produktow, c.CategoryID, c.CategoryName
--	from Products p 
--		left join categories c on c.CategoryID = p.CategoryID
--		group by c.CategoryID, c.CategoryName


---ile produktów kupił dany klient

--select sum(coalesce(od.Quantity, 0)) ilosc_zamowien, CustomerID, coalesce(od.ProductID, 'BRAK') as PRODUKT_ID
--	from Orders o
--	left join [Order Details] od on o.OrderID = od.OrderID
--	group by CustomerID, od.ProductID
--	order by 2 desc,3



----FUNKCJE OKIENKOWE

---zanako wypisać produkty z kategorii i liczbą porządkową zależną od produkt name

--select ROW_NUMBER()over(partition by c.CategoryID order by p.productid) as liczba_porzadkowa_wg_kategoiii, c.Categoryname, p.ProductName
--	from Categories c
--	left join Products p on c.CategoryID =p.CategoryID
--	--group by c.CategoryID, p.ProductName



------SUBSELECTS------

---zaandko - znajdzmy produkty których jest najwięcej na magazynie TOP i subselectem
--pierwszy sposob
--select *
--	from Products
--		where UnitsInStock = (select MAX(UnitsInStock) from Products)
----drugi sposob
--select top (1) UnitsInStock,*
--	from Products p
--	order by p.UnitsInStock desc


----EXCEPT-----


--select convert(nvarchar(100),[SupplierID]) as ID,
--[CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], 'SUPP' from Suppliers
--union --all
--select convert(nvarchar(100),[CustomerID]) as ID, 
--[CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], 'CUST' from Customers



-----INSERT-----
--DML--

--insert dbo.Categories ([CategoryName], [Description], [Picture])
--	values('Hessa bessa', 'su[pa hupa', NULL)
--go;

--select*
--	from Categories

--insert dbo.Products
--	values ('guma balonowa', 2, 9, '23', 666, 666,666,2,1)
--	go
--select *
--	from Products
--		where CategoryID = 9 --or CategoryID =8

----update Products
----set Discontinued = 0
----where CategoryID = 9