/*pisząc komendę "USE" wskazujemy na bazę danych którą chcemy aktualnie używać*/
--USE Northwind
--select * 
--from Customers;


--select CompanyName, Address
--from Customers;

/*CTRL+K+C komentuje kod, CTRL + K + U - odkomentowywanie*/

--select CompanyName, City
--from Customers
--where Country = 'Germany';

--USE Northwind
--select *
--from Products
--where UnitPrice >= 10 and UnitsInStock >= 20;


--OR


--USE Northwind
--select *
--from Customers 
--where Country = 'UK' or Country = 'Germany';

--ISNOTNULL lub IS null

--USE Northwind
--select *
--from Customers 
--where Fax is null;

/*operator LIKE 
wildcard % oznacza wszystkie znaki
_ podkreślink dowolny znak*/

--select CompanyName, City
--from Customers
--where City like 'B%';

--select CompanyName, City
--from Customers
--where City like 'B%a';


--USE Northwind
--select *
--from Customers 
--where Country = 'Germany' AND City like 'M_nchen' or Country = 'France';

--USE Northwind
--select *
--from Customers 
--where Country = 'France' or Country = 'Germany' AND City like 'M_nchen' 

--USE Northwind
--select *
--from Products
--where UnitPrice between 0 and 10;


--polecenie TOP
--USE Northwind
--select top 10 *
--from Products
--order by UnitPrice desc


-- top 20 procent
--USE Northwind
--select top 20 PERCENT *
--from Products
--order by UnitPrice desc;


--Wylistować klientów z Niemiec i wyświetlenie w uporządkowaniu wg. nazwy miasta
--USE Northwind
--select *
--from Customers
--where Country = 'Germany'
--order by @@ROWCOUNT desc
----order by City asc;


--zadanko produkty z kategorią pierwszą i sortoewanie po cenie
--select *, @@ROWCOUNT
--from Products
--where CategoryID = 1 and UnitPrice >=15
--order by UnitPrice desc;

--Zadnako - klienci którzy maja fax i miasto zaczyna się na literę B
--select *
--from Customers
--where Fax is not null and City like 'B%';


--kolejne zadanko

--select *
--from [Order Details]
--where (UnitPrice between 10 and 20) and Discount >0
--order by 3 desc;

--Instrukcje warunkowe IIF i CASE

----select UnitPrice, CASE
----when UnitPrice >20 then 'Wielko'
----else 'Tanio'
----End
----from [Order Details]

--zadanko ze zniżkami i CASE
--select UnitPrice, Discount, CASE
--when Discount <= 0 then 'Gdzie mojo zniżko!'
--when Discount between 0 and 0.1 then 'Mała zniżko! Chce wincyj!'
--else 'Jest dobra zniżko!'
--End
--from [Order Details];

select UnitPrice, Discount, IIF(Discount <= 0,'Gdzie mojo zniżko!','Jest dobra zniżko!')
from [Order Details]