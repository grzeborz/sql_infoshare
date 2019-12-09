

--zadanie: Tabela Customers, wypisać liczbę porządkową dla partycji która jest kolumna City
--w obrębie partycji sortowanie po CompanyName

--use Northwind
--go
--select ROW_NUMBER()over(partition by City order by companyname) as numer_wiersza, CompanyName, City
--from Customers


--Podobne zadanie z wykorzystaniem join na tabelach Categories i Products. Partycją jest CategoryId, sortowanie po productId

--use Northwind
--go
--select ROW_NUMBER()over(partition by c.CategoryID order by p.productID) as numer_wiersza, c.CategoryID,c.CategoryName, p.ProductID, p.ProductName
--	from Categories c
--	join Products p on c.CategoryID = p.CategoryID


-----COALESCE----

--zadanie dla każdego klienta (Tabela Customers) wypisać ile zakupił sztuk towaru 
--(łącznie niezależnie od tego co to były za towary) - tabela Order Details kolumna Quantity
--use Northwind
--go
--select distinct
--sum(coalesce(od.Quantity, 0))over(partition by c.customerid order by c.companyname) suma_zamowien, 
--c.CustomerID, 
--c.companyname
--	from Customers c
--		left join Orders o on c.CustomerID=o.CustomerID
--			left join [Order Details] od on o.OrderID=od.OrderID
			
--			order by 1 desc


--use Northwind
--go
--select 
--sum(coalesce(od.Quantity, 0)) suma_zamowien, 
--c.CustomerID, 
--c.companyname
--	from Customers c
--		left join Orders o on c.CustomerID=o.CustomerID
--			left join [Order Details] od on o.OrderID=od.OrderID
--			group by c.CustomerID, c.companyname
--			having sum(coalesce(od.Quantity, 0)) > 100
--			order by 1 desc


--zadanie dla każdej kategorii (Tabela categories) wypisać ile zakupił sztuk towaru 
--(łącznie niezależnie od tego co to były za towary) - tabela Order Details kolumna Quantity

--use Northwind
--go
--select c.CategoryName,
--		c.CategoryID,
--		sum(coalesce(od.Quantity, 0)) suma_prod
--	from Categories c
--		left join Products p on c.CategoryID=p.CategoryID
--			left join [Order Details] od on p.ProductID=od.ProductID
--				group by c.CategoryName,c.CategoryID
--				order by 3 desc


--use Northwind
--go
--select distinct c.CategoryName,
--		c.CategoryID,
--		sum(coalesce(od.Quantity, 0)) over(partition by c.categoryid) suma_prod
--	from Categories c
--		left join Products p on c.CategoryID=p.CategoryID
--			left join [Order Details] od on p.ProductID=od.ProductID
--				--group by c.CategoryName,c.CategoryID
--				order by 3 desc

----zadanko powtorzeniowe ----UNION-----
--select e.FirstName + ' ' + e.LastName as NAME,
--		e.Address,
--		e.City,
--		e.Region,
--		e.PostalCode,
--		e.Country,
--		e.HomePhone,
--		'EMPLOYEES'
--		from employees e
--			union
--				select c.ContactName,
--					c.Address,
--					c.City,
--					c.Region,
--					c.PostalCode,
--					c.Country,
--					c.Phone,
--					'CUSTOMERS'
--					from Customers c
--					order by 1




----SUB SELECT---

--znlaeźć produkt który ma najwyższą cenę
--use Northwind
--go
--select *
--	from Products
--		where UnitPrice in (select max(pp.UnitPrice)
--	from Products pp)


----SUB STRING----
--zadano - wyciąc imie i nazwoisko z tabeli customers uzywajac funkcji --substring, left, len, itp
--use Northwind
--go
--select SUBSTRING(ContactName, 1, CHARINDEX(' ', ContactName)-1) as name,
--	SUBSTRING(ContactName, CHARINDEX(' ', ContactName)+1, LEN(ContactName)) as surname
--	from Customers
	

--use Northwind
--go
--select reverse(left(SUBSTRING(ContactName, CHARINDEX(' ', ContactName)+1, LEN(ContactName)), CHARINDEX(' ',SUBSTRING(ContactName, CHARINDEX(' ', ContactName)+1, LEN(ContactName)-1)))) as surname
--	from Customers


--use Northwind
--go
--select 
--		case 
--			when SUBSTRING(ContactName, CHARINDEX(' ', ContactName)+1, LEN(ContactName)) like '% %' then
--			right((SUBSTRING(ContactName, CHARINDEX(' ', ContactName)+1, LEN(ContactName))), CHARINDEX(' ', SUBSTRING(ContactName, CHARINDEX(' ', ContactName)+1, LEN(ContactName))))
--			else SUBSTRING(ContactName, CHARINDEX(' ', ContactName)+1, LEN(ContactName))
--		end
--	from Customers
--	where ContactName like '%tro'

--select *
--		from Customers
--	where ContactName like '%tro'

	---jarka kod
	--select reverse(left(reverse(ContactName), charindex(' ', reverse(ContactName))-1))
	--	from Customers


----TRANSLATE----
--w funckji translate usuwamy znaki parami - nie mozna usuwać znaków zamieniając na empty
--use Northwind
--go
--select Fax,replace(coalesce(Fax, ''), '-', '')
--	from Customers

--use Northwind
--go
--select Fax,replace(translate(coalesce(Fax, ''), '-().','    '), ' ','')
--	from Customers

