---FUNKCJA---

--use Northwind
--go
--create function dodaj(@arg1 int, @arg2 int)
--returns int
--begin
--	return @arg1 + @arg2;
--end

--select dbo.dodaj(1,1)

--use Northwind
--go
--create function ponozPrzez2(@arg float)
--returns float
--begin
--	return @arg*2;
--end

--select dbo.ponozPrzez2(2)

--select UnitPrice, dbo.ponozPrzez2(2) from Products

--Stwórz funkcję obliczającą cenę towaru--
--use Northwind
--go
--create function dbo.podajCeneTowaru(@unitPrice money, @quantity int, @discount float)
--returns money
--begin
--	return (@unitPrice * @quantity)*(1-@discount)
--end

--go
--select dbo.podajCeneTowaru(unitprice, Quantity, Discount), UnitPrice, Quantity, Discount from [Order Details]

---ZADANKO ---
--1. Należy napisać funkcję, która będzie usuwać z napisu który reprezentuje telefon niepotrzebne znaki.
--TRANSLARE, REPLACE
--2. Tabelka Customers. Należy nową funkcję użyć do zaktualizowania kolumny Phone.

use Northwind
go
drop function if exists bezZnakowSpecjalnych
go
create function bezZnakowSpecjalnych(@telefon nvarchar(100))
returns nvarchar(100)
as
begin
	return replace(translate(@telefon, '!@#$%^&*()_+.-{}|:"?><'' ','XXXXXXXXXXXXXXXXXXXXXXXX'),'X', '')
end

--select dbo.bezZnakowSpecjalnych('$#123456#$%6 :>?''78')

select dbo.bezZnakowSpecjalnych(fax), fax from Customers

--jeśli teraz chciałbym updateować kolumne to mogę--
--update Customers set Phone = dbo.bezZnakowSpecjalnych(Phone)