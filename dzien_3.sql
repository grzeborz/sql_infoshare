--USE Northwind
--select * 
--	from Customers
--	where CompanyName like'% %' and CompanyName not like '% % %'

--COUNT
--USE Northwind
--select count(1), COUNT(fax), COUNT(companyname)
--	from Customers
--	--where CompanyName like'% %' and CompanyName not like '% % %'

--FUNKCJE AGREGUJĄCE
--USE Northwind
--select count(1), MIN(unitprice),Max(unitprice),
--	sum(unitprice), avg(unitprice)
--	from [Order Details];


--USE Northwind
--select CategoryID, avg(unitprice) as srednia_cena
--	from Products
--	group by CategoryID

--USE Northwind
--select CategoryID, avg(unitprice) as srednia_cena
--	from Products
--	where CategoryID != 2
--	group by CategoryID
--	having avg(unitprice) > 10

---ekwiwalent tego wyższego gdzie warunek dajemy w HAVING
--USE Northwind
--select CategoryID, avg(unitprice) as srednia_cena
--	from Products
--	group by CategoryID
--	having avg(unitprice) > 10 and CategoryID != 2;

--Wszystko co zawiera się w WHERE nie wchodzi w skłąd obliczeń - jest wtedy szybkie


---JOIN---

--USE Northwind
--select *
--	from Products p
--	join Categories c on p.CategoryID=c.CategoryID

--USE Northwind
--select p.ProductName, c.CategoryName
--	from Products p
--	join Categories c on p.CategoryID=c.CategoryID


--LEFT JOIN
--USE Northwind
--select p.ProductName, c.CategoryName
--	from Products p
--	left join Categories c on p.CategoryID=c.CategoryID

--zadanko - pobrac cene i dodac srednia cene jako pole
--USE Northwind
--go
--select c.CategoryName, AVG(p.unitprice) srednia_cena
--	from Products p
--	left join Categories c on p.CategoryID=c.CategoryID
--	group by c.CategoryName


---podwojne grupowanie
--USE Northwind
--go
--select count(1) liczba_elementow, p.CategoryID--, p.SupplierID
--	from Products p
--	left join Categories c on p.CategoryID=c.CategoryID
--	group by p.CategoryID--, p.SupplierID
	

------COLEASCE----
--USE Northwind
--go
--select count(1) liczba_elementow, p.CategoryID--, p.SupplierID
--	from Products p
--	left join Categories c on p.CategoryID=c.CategoryID
--	group by p.CategoryID--, p.SupplierID


---INSERT---
--insert into Categories(categoryname, description) 
--	values ('nowa', 'opis');

--USE Northwind
--go
--select sum(coalesce(unitprice, 0)) suma_wartosci,AVG(coalesce(unitprice, 0)) as srednia_wartosc,
--	min(coalesce(unitprice, 0)) najmnijesza_cena,
--	max(coalesce(unitprice, 0)) najwyzsza_cena, 
--	count(1) liczba_elementow, p.CategoryID, p.ProductName
--	from Products p
--	join Categories c on p.CategoryID=c.CategoryID
--	group by p.CategoryID, p.ProductName

--USE Northwind
--go
--select sum(coalesce(unitprice, 0)) suma_wartosci,AVG(coalesce(unitprice, 0)) as srednia_wartosc,
--	min(coalesce(unitprice, 0)) najmnijesza_cena,
--	max(coalesce(unitprice, 0)) najwyzsza_cena, 
--	count(1) liczba_elementow, p.CategoryID, p.ProductName
--	from Categories c
--	join Products p on c.CategoryID=p.CategoryID
--	group by p.CategoryID, p.ProductName

--USE Northwind
--go
--select count(1), ProductName, SUM(unitprice)
--	from Categories c
--	left join Products p on c.CategoryID=p.CategoryID
--	group by p.ProductName


---zadanko - klienci i ich zamówiuenia - ile każdy klient dokonał zamówień 
--USE Northwind
--go
--select count(o.CustomerID) liczba_zamowien, SUM(coalesce(od.unitprice, 0)) ile_hajsu_wydal, 
--	c.CustomerID, round(SUM(coalesce(od.discount, 0)*100),0,2) suma_znizek_w_procentach
--	from Customers c
--	left join Orders o on c.CustomerID=o.CustomerID
--	left join [Order Details] od on o.OrderID=od.OrderID
--	group by c.CustomerID
--	order by 1 asc

---ile jest produktów jest w kategorii
USE Northwind
go
select c.CategoryID as Kategoria, count(p.productid) liczba_produktow, 
	SUM(coalesce(od.unitprice, 0)) suma_wartosci_produktow,
	SUM(coalesce(od.unitprice, 0)/count(p.productid)) srednia_wartosc_produktow
	from Categories c
	left join Products p on c.CategoryID=p.CategoryID
	left join [Order Details] od on p.ProductId=od.ProductId
	group by c.CategoryID
	order by 1 asc
