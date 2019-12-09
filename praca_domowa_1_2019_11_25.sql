/*
Zadanie domowe cz1
1. Pobrać klientów (Customers) z miasta mającego w sobie literę "a" na drugiej pozycji.
2. Pobrać pracowników (Employees) i posortować wynik po Country, Region, PostalCode
3. Wylistować wiersze z order details które mają UnitPrice pomiędzy 10 i 20, jednocześnie podsiadające jakąś zniżkę
cz2
1.    Wypisać wszystkie kategorie i ilość produktów przypisanych do danej kategorii - kurwa z której tabeli
2.    Wypisać dane klienta, który zrobił najwiecej zamówień. Jeśli kilku klientów posiada maksymalną liczbę zamówień należy wylistować wszystkich. (edited) 
zadanie z gwiazdka:
3.    Policzyć sumę wartości zamówień (Order Details – UnitPrice, Quantity, Discount) w każdym roku.
Wszystkie zadania będę wykonane i wytłumaczone w poniedziałek.
*/
/*
1
USE Northwind
go
select *
	from Customers
	where City like '_a%';
	*/

--2
/*
USE Northwind
go
select *
	from Employees
	order by Country,Region, PostalCode;
	*/

--3. 
--USE Northwind
--go
--select *
--	from [Order Details]
--	where UnitPrice between 10 and 20 and 
--	Discount <> 0;

--4.
--USE Northwind
--go
--select count(ProductID) ilosc_produktow, p.CategoryID, c.CategoryName
--	from Products p
--	join Categories c on p.CategoryID = c.CategoryID
--	group by p.CategoryID, c.CategoryName



--	Wypisać dane klienta, który zrobił najwiecej zamówień. Jeśli kilku klientów posiada maksymalną liczbę zamówień należy wylistować wszystkich. (edited) 
--zadanie z gwiazdka:
--3.    Policzyć sumę wartości zamówień (Order Details – UnitPrice, Quantity, Discount) w każdym roku.
--Wszystkie zadania będę wykonane i wytłumaczone w poniedziałe


--5
--USE Northwind
--go
--select top 1 with ties count(o.CustomerID) liczba_zamowien, SUM(coalesce(od.unitprice, 0)) ile_hajsu_wydal, 
--	c.CustomerID, round(SUM(coalesce(od.discount, 0)*100),0,2) suma_znizek_w_procentach
--	from Customers c
--	left join Orders o on c.CustomerID=o.CustomerID
--	--left join [Order Details] od on o.OrderID=od.OrderID
--	group by c.CustomerID
--	order by 1 desc

--USE Northwind
--go
--select *
--	from Customers as t where t.CustomerID=(
--		select top 1 with ties count(1) liczba_zamowien, c.CustomerID
--			from Customers c
--			left join Orders o on c.CustomerID=o.CustomerID
--			group by c.CustomerID
--			order by 1 desc)


--6
--USE Northwind
--go
--select count(o.CustomerID) liczba_zamowien, SUM(coalesce(od.unitprice, 0)) ile_hajsu_wydal, 
--	c.CustomerID, round(SUM(coalesce(od.discount, 0)*100),0,2) suma_znizek_w_procentach, year(OrderDate),
--	SUM(coalesce(od.unitprice, 0))over(partition by year(OrderDate)) 
--	from Customers c
--	left join Orders o on c.CustomerID=o.CustomerID
--	left join [Order Details] od on o.OrderID=od.OrderID
--	group by c.CustomerID, year(OrderDate)
--	order by 1 desc

--select *
--from Orders


--USE Northwind
--go
--select distinct year(OrderDate),
--	SUM((od.unitprice * od.Quantity)*(1-(od.Discount)))over(partition by year(OrderDate)) as kasa
--	--SUM(od.Quantity)over(partition by year(OrderDate)) as ilosc,
--	--SUM(od.Discount)over(partition by year(OrderDate)) as znizki
--	from Customers c
--	left join Orders o on c.CustomerID=o.CustomerID
--	left join [Order Details] od on o.OrderID=od.OrderID
--	order by 1 desc



--USE Northwind
--go
--select SUM((od.unitprice * od.Quantity)*(1-(od.Discount))) as turnover, year(OrderDate) as rok
--from Customers c
--	left join Orders o on c.CustomerID=o.CustomerID
--	left join [Order Details] od on o.OrderID=od.OrderID
--	group by year(OrderDate)
--	order by 2 desc


