--a) sprawdzenie czy liczba jest liczba pierwza
--use northwind
--go
--declare @pierwsza int = 9
--select @pierwsza, 
--		case
--			when @pierwsza = 0 then 'Liczba '+ convert(nvarchar(10), @pierwsza)+ ' nie jest liczba pierwsza ani liczba złożona'
--			when @pierwsza = 1 then 'Liczba '+ convert(nvarchar(10), @pierwsza)+ ' nie jest liczba pierwsza ani liczba złożona'
--			when @pierwsza = 2 then 'Liczba '+ convert(nvarchar(10), @pierwsza)+ ' jest liczba pierwsza'
--			when @pierwsza = 3 then 'Liczba '+ convert(nvarchar(10), @pierwsza)+ ' jest liczba pierwsza'
--			when ((@pierwsza % 2 = 0) and (@pierwsza % 3 = 0)) then 'Liczba '+ convert(nvarchar(10), @pierwsza)+ ' nie jest liczba pierwsza'
--			when ((@pierwsza % 2 = 0) or (@pierwsza % 3 = 0)) then 'Liczba '+ convert(nvarchar(10), @pierwsza)+ ' nie jest liczba pierwsza'
--			else 'Liczba '+ convert(nvarchar(10), @pierwsza)+ ' jest liczba pierwsza'
--		end


--b) znalezienie najwiekszej liczby pierwszej w zadanym przedziale

--select 3%3

--IF DATENAME(weekday, GETDATE()) IN (N'Saturday', N'Sunday')
--       SELECT 'Weekend';
--ELSE 
--       SELECT 'Weekday';

--drop table prime
--create table prime (primeno bigint)
--declare @counter bigint
--set @counter = 2
--while @counter < 10
--	begin
--		if not exists(select top 1 primeno from prime where @counter % primeno = 0 )

--		insert into prime select @counter
--		set @counter = @counter + 1
--	end
--select * from prime order by 1


with pierwsza as (
--declare @pierwsza int = 9
select (declare @pierwsza int = 9 as pierwej
)
select * from pierwsza