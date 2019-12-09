------DEKALROWANIE ZMIENNEJ ----
--declare @zmienna nvarchar(15);
--set @zmienna = 'moja_zmienna';

--select @zmienna

------ten sam sposó ale jednolinijkowiec
--declare @zmienna_pierwsza nvarchar(100) = 'trzydwajeden';
--select @zmienna_pierwsza

--print @zmienna_pierwsza


----deklarownie zmiennej w taki sposób trzeba robić to tak by zwracło tylko jedną zmienna
--declare @price money
--select @price = unitprice 
--	from Products
--print @price


---sposób na wiele zmiennych
--declare @price money
--declare @name nvarchar(10)
--select @price = unitprice, @name = ProductName
--	from Products
--print @price
--print @name
--print @price


----print - wyrzuca info do zakładi messages - i jest dobre do debugowania - np przy każdym koljenym kroku

----INKREMENTOWANIE ZMIENNYCH - dobre do ifów

--declare @x int =10;
--print 'deklarowanie zmiennej przeszło pozytywnie'
--set @x = 10
--print 'deklarowanie zmiennej ktora równa się: '+convert(nvarchar(10),@x)
--set @x = @x -5
--print 'odejmownie od zmiennej 5, zmienna równa się: '+convert(nvarchar(10),@x)
--set @x = @x *2
--print 'mnozenie zmiennej przez 2, zmienna równa się: '+convert(nvarchar(10),@x)
--print @x
--select @x
----select @x


--declare @srednia money
--declare @min_srednia money
--declare @max_srednia money
--set @srednia = (select avg(unitprice)
--	from Products)
--print 'srednia = '+convert(nvarchar(10),@srednia)
--set @min_srednia = @srednia*0.9
--print 'min srednia = '+convert(nvarchar(10),@min_srednia)
--set @max_srednia = @srednia*1.1
--print 'max srednia = '+convert(nvarchar(10),@max_srednia)
----select *, @srednia, @min_srednia, @max_srednia
----	from Products
----		where UnitPrice between @min_srednia and @max_srednia
--select case
--			when UnitPrice between @min_srednia and @max_srednia then 'produkt sredni'
--			when UnitPrice > @min_srednia then 'tani produkt'
--			when UnitPrice < @max_srednia then 'produkt ekskluzywny'
--			--else 'produkt w cenie sredniej'
--		end as kategorzacja_cen, UnitPrice, ProductName
--from Products

------DRUGI SPOSOB


--declare @srednia money = (select avg(unitprice)
--								from Products)
--select case
--			when unitprice >= 0.9*@srednia and UnitPrice <1.1*@srednia then 
--@srednia
--from Products


--declare @maxprice money = (select max(UnitPrice * Quantity)
--							from [Order Details])
----select @maxprice as maxprice
--declare @discountBias money = @maxprice * 0.8
--print 'znizka wynosi = '+CAST(@discountBias AS nvarchar (10))
----CAST ( expression AS data_type [ ( length ) ] ) 
----convert(nvarchar(10),@max_srednia)
----select @discountBias as znizka
----select(UnitPrice*Quantity) as wartosc, *
----from [Order Details]
----where (UnitPrice*Quantity) >= @discountBias
--select (UnitPrice*Quantity) as wartosc,
--	case
--		when (UnitPrice*Quantity) >= @discountBias then 'znizka'
--		else 'brak znizki'
--	end as wynik_analizy, UnitPrice, *
--	from [Order Details]
--	--where OrderID = 10865 or OrderID = 10981
--	order by 2 desc



----INSTRUKCJE WARUNKOWE IF -----

--declare @x int = 10
--if @x > 10
--	print 'wieksze'
--else if @x <= 10
--	print 'super'
--print 'niezaleznie od wyniku sie wypisze'


--zadanko

--declare @minimum int = (select min(UnitPrice)
--	from Products)
--declare @maximum int = (select max(UnitPrice)
--	from Products)
--if @maximum - @minimum >= 100
--	print 'duze roznice w cenach'
--else
--	print 'male roznice w cenach'

--drugie rozwiazania
--declare @minimum int = (select min(UnitPrice)
--	from Products)
--	print 'min wynosi = '+CAST(@minimum AS nvarchar (10))
--declare @maximum int = (select max(UnitPrice)
--	from Products)
--	print 'max wynosi = '+CAST(@maximum AS nvarchar (10))
--if @maximum - @minimum >= 100
--	print 'duze roznice w cenach'
--else
--	print 'male roznice w cenach'

--select * from [Order Details] where Quantity <= 0;

------EXIST-----
--najabardziej szybkie i optymalne
--if exists
--	(select 1 from [Order Details] where Quantity <= 0)
--	print 'wynik z funkcji EXISTS = istnieją niepoprawne zamówienia'
--print 'wynik z funkcji EXISTS = OK';

----nieoptymalne - bo iteruje po wszystkich wierszach
--if (select count(1) from [Order Details] where Quantity <= 0) > 0
--	print 'wynik z funkcji COUNT = istnieją niepoprawne zamówienia'
--print 'wynik z funkcji COUNT = OK';


---nowe zadanko
--if exists (select 1 from Products where UnitsOnOrder > UnitsInStock)
--	print 'jest problemik'
--else 
--	print'jest ok'



-----PETLE WHILE ----

--declare @wykladnik int = 4
--declare @potega int = 1
--declare @i int = 1

--while @i <= @wykladnik
--	begin
--		print 'Potęga 1 liczby '+convert(nvarchar(5),@i) + ' = '+convert(nvarchar(5),@potega)
--		set @potega = @potega * 2
--		set @i = @i +1
--	end

--zadanko od jarka
--declare @wykladnik int = 100
--declare @potega int = 1
--declare @i int = 0
--while @i <= @wykladnik
--begin
--	print 'Potega ' + convert(nvarchar(5), @i) + ' liczby 2 to ' + convert(nvarchar(5), @potega)
--	set @potega = @potega * 2
--	set @i = @i + 1
--end

--zadanko z silniami

declare @silnia float = 8
declare @wynik float = 1
declare @i float = 1

while @i < @silnia
begin
	PRINT convert(nvarchar(5), @i) + ' '+convert(nvarchar(5), @wynik)
		set @i = @i + 1
		set @wynik = (@wynik * @i)
	--PRINT convert(nvarchar(5), @wynik)
end
print 'Wynik silni liczby '+convert(nvarchar(5),@silnia)+' wynosi = '+ +convert(nvarchar(5), @wynik)