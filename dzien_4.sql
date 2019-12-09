--USE Northwind
--go
--select distinct s.SupplierID, c.CategoryID, c.CategoryName
--	from Suppliers s
--	left join Products p on s.SupplierID=p.SupplierID
--	left join Categories c on p.CategoryID=c.CategoryID
--	--left join [Order Details] on 
--	order by 1,2

---WINDOW FUNCTION
--USE Northwind
--go
--select distinct c.CategoryID, c.CategoryName,
--	sum((o.UnitPrice*o.Quantity)*(1-(o.Discount)))over(partition by c.CategoryID) as turnover
--	from Categories c
--	left join Products p on c.CategoryID=p.CategoryID
--	left join [Order Details] o on p.ProductID=o.ProductID

--uzywajac tylko group by
--USE Northwind
--go
--select  c.CategoryID, c.CategoryName,
--	coalesce(sum((o.UnitPrice*o.Quantity)*(1-(o.Discount))),0) as turnover
--	from Categories c
--	left join Products p on c.CategoryID=p.CategoryID
--	left join [Order Details] o on p.ProductID=o.ProductID
--	group by c.CategoryID, c.CategoryName
--	order by 1


--USE Northwind
--go
--select cc.categoryid from Categories cc where cc.CategoryID in (
--select  *,
--	sum((o.UnitPrice*o.Quantity)*(1-(o.Discount))) as turnover
--	from Categories c
--	left join Products p on c.CategoryID=p.CategoryID
--	left join [Order Details] o on p.ProductID=o.ProductID
--	group by c.CategoryID)

---ile jest ludzi w customertypeid z podziałem na terytoria

--USE Northwind
--go
--select count(1) liczba_pracownikow, t.TerritoryID, t.TerritoryDescription
--	from Employees e 
--		left join EmployeeTerritories et on e.EmployeeID=et.EmployeeID
--		left join Territories t on et.TerritoryID=t.TerritoryID
--		left join Region r on t.RegionID=r.RegionID
--		group by t.TerritoryID, t.TerritoryDescription
--		order by 1 desc


---ile jest ludzi w customertypeid z podziałem na regiony
--USE Northwind
--go
--select count(1) liczba_pracownikow, r.RegionID, r.RegionDescription
--	from Employees e 
--		left join EmployeeTerritories et on e.EmployeeID=et.EmployeeID
--		left join Territories t on et.TerritoryID=t.TerritoryID
--		left join Region r on t.RegionID=r.RegionID
--		group by r.RegionID, r.RegionDescription
--		order by 1 desc

---ile jest ludzi w customertypeid z podziałem na regiony i terytoria
--USE Northwind
--go
--select count(1) liczba_pracownikow, r.RegionID, r.RegionDescription, t.TerritoryID, t.TerritoryDescription
--	from Employees e 
--		left join EmployeeTerritories et on e.EmployeeID=et.EmployeeID
--		left join Territories t on et.TerritoryID=t.TerritoryID
--		left join Region r on t.RegionID=r.RegionID
--		group by r.RegionID, r.RegionDescription, t.TerritoryID, t.TerritoryDescription
--		order by 2, 4 desc

---ile jest ludzi w customertypeid z podziałem na regiony i kraje
--USE Northwind
--go
--select count(1) liczba_pracownikow, r.RegionID, r.RegionDescription, e.Country, e.Region
--	from Employees e 
--		right join EmployeeTerritories et on e.EmployeeID=et.EmployeeID
--		right join Territories t on et.TerritoryID=t.TerritoryID
--		right join Region r on t.RegionID=r.RegionID
--		group by r.RegionID, r.RegionDescription, e.Country, e.Region
--		order by 2, 4 desc
----union
--	select count(1) suma
--		from Employees


--znaleźć praconikwów których wiek jest wyższy niż średnia
--USE Northwind
--go
--select --e.EmployeeID, 
--	e.FirstName+' '+e.LastName,
--	datediff(year, BirthDate, GETDATE()) wiek_pracownika
--	FROM Employees e
--	where datediff(year, e.BirthDate, GETDATE()) > (select avg(datediff(year, ee.BirthDate, GETDATE())) from Employees ee)
--	order by 2 desc
--union all
--select 'the sum', avg(datediff(year, ee.BirthDate, GETDATE())) srednia_wieku_pracownikow from Employees ee;

---znalezc produkt ktory jest z najwyzasza cena jesli kilka ma taka to wypisz wszystkie
--select top 1 
--	with ties ProductName
--	from Products pp
--		where UnitPrice in (
--							select max(pp.unitprice)
--								from Products pp)


--select *
--	from Products pp
--		where UnitPrice in (
--							select max(pp.unitprice)
--								from Products pp)



--kategorie z produktem - i chcielibyśmy mieć id produktu i category id i liczbę porządkową której partycją kjest 
--kategoria i by było posortowane po product ID

--USE Northwind
--go
--select 
--		ROW_NUMBER()over(partition by p.categoryid order by p.productid) numer_wiersza,
--		c.CategoryName,
--		p.ProductName
--	from Categories c
--		left join Products p on c.CategoryID=p.CategoryID
--			--where p.ProductName is not null


---UNION ALL ---
--UNION ALL zwróci wszystkie rekordy również zduplikue rekordy - UNION zwróci wszystkie bez duplikacji
--USE Northwind
--go
--select FirstName, LastName, datediff(year, BirthDate, getdate())
--	from Employees
--	union all
--	select 'GRAND', 'TOTAL', sum(datediff(year, BirthDate, getdate())) from Employees


---INTERSECT---
--USE Northwind
--go
--select '1'
--	from Employees
--	intersect
--	select '1' from Employees


---zadanko - lista miast z którymi współpracujemy - czyli lista miast dostawców i klientów
select distinct City
	from Suppliers s
union all
select distinct city 
	from Customers

select City
	from Suppliers s
union
select city 
	from Customers