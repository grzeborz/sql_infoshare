--Wyszukać klientów którzy mają fax i mieszkają w miejście które rozpoczyna się na literę L
--use Northwind
--select *
--	from Customers
--	where Fax is not null and City like 'l%';

--zadanko - pracownicy z niemiec(brak) więc z UK i posortujmy po miescie
--select *
--	from Employees
--	where Country = 'uk'
--	order by City asc;


--zadanko - dodać case i jesli unit price bedzie pow 20 unit price to wyświetlić napis 'duza cena' w innym wypadku 'mala cena'
--select *, case 
--			when UnitPrice > 20 then 'Duża cena'
--			else 'Mała cena'
--		end
--	from [Order Details]


--zadanko GET DATE 

--select GETDATE() as TIMESTAMP

--w ORACLE DB jesli chcemy odwołac isę do tbaleki "pustej" nitetnijejące j- trzbea odwołać isę do tabeli o nazwie "DUAL"

--select datediff(day,OrderDate, ShippedDate) as roznica, datediff(day,OrderDate, getdate()) as rozn_dzien_dzisisejszy
		
--	from Orders


---imie nazwisko i ile lat ktos pracuje w firmie -pole hiredate oznacza dzien zatrudnienia

--select LastName, FirstName, datediff(year, HireDate, GETDATE()) as ile_to_juz_lat_minelo
--	from Employees;

--tutaj to samo ale jako napis i konkatenacja 
--select LastName +' '+FirstName+ ' pracuje w firmie '+ cast(datediff(year, HireDate, GETDATE())as varchar) + ' lat. Natomiast pracownik jest w wieku '+cast(datediff(year, BirthDate, GETDATE())as varchar) + ' lat'
--	from Employees;

--to samo tylko wiek
--select LastName, FirstName, datediff(year, BirthDate, GETDATE()) as ile_to_juz_lat_minelo_od_narodzin
--	from Employees;

--to samo tylko pobieramy pracowników pełnoletnich
--with wiek as(
--select LastName, FirstName, datediff(year, BirthDate, GETDATE()) as ile_to_juz_lat_minelo_od_narodzin
--	from Employees)
--	select *
--		from wiek
--		where ile_to_juz_lat_minelo_od_narodzin > 18
--		order by 3;

--to samo tylko pobieramy pracowników pełnoletnich ale sposobem prostym
--select LastName, FirstName, datediff(year, BirthDate, GETDATE()) as ile_to_juz_lat_minelo_od_narodzin
--	from Employees
--	where datediff(year, BirthDate, GETDATE()) >= 18;

--select LastName, FirstName, datediff(year, BirthDate, GETDATE()) as ile_to_juz_lat_minelo_od_narodzin, (GETDATE()-cast(18)datetime)
--	from Employees
--	where year(Birthdate) < (GETDATE()+18);

--select top 1 * --LastName, FirstName, datediff(year, BirthDate, GETDATE()) as ile_to_juz_lat_minelo_od_narodzin
--	from Employees
--	order by BirthDate desc;


--select (year(18))

--GROUP BY i funkcje agregujace

--select count(1),country
--	from Employees
--	group by Country

--select count(1),country
--	from Customers
--	group by Country;

--select count(@@ROWCOUNT),country
--	from Customers
--	group by Country

--select avg(unitprice), COUNT(1) as l_kategorii, CategoryID
--	from Products
--	group by CategoryID


--zadanko -- ile mamy pracowników w każdym miescie
--select COUNT(1) as liczba_nierobow, City, Country, avg(datediff(year, BirthDate, GETDATE())) as srednia_wieku
--	from Employees
--	group by City, Country
--	order by 1, 4;

	
--select (year(18))


---zadanko znaleźć cenę najtańszego produktu w każdej kategorii

--select /*COUNT(1) liczba_produktow,*/ min(UnitPrice), CategoryID
--	from Products
--	group by CategoryID
--	order by CategoryID

--DZIAŁA ODEJMOWANIE LAT
--select dateadd(year, -18, GETDATE())

---By pobrać pracowników którzy są pełnoletni - zmienna zamiast hardcodowanej wartości 18lat
--select LastName, FirstName, datediff(year, BirthDate, GETDATE()) as ile_to_juz_lat_minelo_od_narodzin
--	from Employees
--	where year(Birthdate) < dateadd(year, -18, GETDATE());

--lub


--select LastName, FirstName, datediff(year, BirthDate, GETDATE()) as ile_to_juz_lat_minelo_od_narodzin
--	from Employees
--	where datediff(year, getdate(), birthdate) > 18;



---zadanko - tab order details  - unitpriuce - srednia cena produktu która posiada zniżkę
--select avg(unitprice) srednia_cena, ProductID, COUNT(productid)
--	from [Order Details]
--	where Discount > 0
--	group by ProductID
--	order by 1 desc


---HAVING ---

--select SupplierID, COUNT(1)
--	from Products
--	where CategoryID = 1
--	group by SupplierID
--	having count(1) >= 2--SupplierID = 1

--1 krok
--select *
--	from Customers 
--	where City in ('Sao Paulo', 'Buenos Aires', 'London');

--2 krok
--select City, COUNT(1)
--	from Customers 
--	where City in ('Sao Paulo', 'Buenos Aires', 'London')
--	group by City
--	having count(1) >=4
