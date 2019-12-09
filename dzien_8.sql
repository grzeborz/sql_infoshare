--zadanko zadeklaruj zmiennąi przypisz do niej maxa z UNITS in STOCK z tabeli products
--use Northwind
--go

--declare @max_unitstock float = (select max(UnitsInStock) from Products)
--print @max_unitstock

--mozna deklarować kilka zmiennych 
--declare @pierwsza int, @druga float, @trzecia nvarchar(255);

--declare @name nvarchar(15), @surname nvarchar(20)
--select @name=FirstName from Employees
--print @name


--zadanko w otóryn 
--declare @unitprice money, @prodid int;

--select @prodid = ProductID, @unitprice = UnitPrice
--	from Products
--		order by UnitPrice asc
--print 'Id produktu to jest równe "'+convert(nvarchar(5), @prodid) 
--	+'", a jego wartość w walucie jest równa '
--	+convert(nvarchar(10), @unitprice)+'$'



----powtórka IF

--declare @sumUnitsInStock float, @sumUnitsOnOrder float;

--set @sumUnitsInStock = (select SUM(UnitsInStock) from Products)
--set @sumUnitsOnOrder = (select SUM(UnitsOnOrder) from Products)

--print 'Liczba produktów na magazynie jest równa: '+convert(nvarchar(10), @sumUnitsInStock)
--print 'Liczba produktów zamówionych jest równa: '+convert(nvarchar(10), @sumUnitsOnOrder)

--if (@sumUnitsOnOrder > @sumUnitsInStock)
--	print 'malo'
--else
--	print 'duzo'



---zanadnko sumaquantiti i unitsinstock, jesli suma quantiti jest wieksza niz ta na magazynie to wyswietl mi blad

--declare @sumUnitsInStock float, @sumQuantity float;

--set @sumUnitsInStock = (select SUM(UnitsInStock) from Products)
--set @sumQuantity = (select SUM(Quantity) from [Order Details])

--print 'Liczba produktów na magazynie jest równa: '+convert(nvarchar(10), @sumUnitsInStock)
--print 'Liczba produktów zamówionych jest równa: '+convert(nvarchar(10), @sumQuantity)

--if (@sumQuantity > @sumUnitsInStock)
--	print 'ErrorLog'
--else
--	print 'Duzo'


---zadnko z pracy domowej

--declare @n int = 3, @temp int =1, @suma int = 0;
--while @temp <= @n
--begin
--	print @temp
--	print @suma + (@temp * @temp)
--	set @suma = @suma + (@temp * @temp)
--	print @temp + 1
--	set @temp = @temp + 1
--	print @temp
	
--end
--print @suma


declare @n int =5, @i int = 0, @in int = 5;
declare @choinka nvarchar(10) = '*'
print @choinka
--declare @whitespace nvarchar(10) = '    '
declare @whitespace nvarchar(10) = '#$%^'
print @whitespace
--print convert(nvarchar(10), @whitespace)+''+ convert(nvarchar(10), @choinka)
--SELECT LEFT('abcdefg',len('abcdefg')-1);  
--GO  

----while @i < @n
----begin 
----	print @choinka
----	set @i = @i + 1
----	set @choinka = @choinka + '*'
----end

while @i < @n
begin
	print convert(nvarchar(10), @whitespace)+ convert(nvarchar(10), @choinka)
	set @whitespace = (select left(@whitespace, LEN(@whitespace)-1))
	set @i = @i + 1
	set @choinka = @choinka + '**'
end


---zadanko
--1 2 3 4  5 
--1 3 6 10 15

--declare @n int = 5, @i int = 1, @m int = 0

--while @i <= @n
--begin
--	--print @i
--	set @m = @m + @i
--	set @i = @i + 1
--	--print @m
--end
--print @m

-----

--declare @n int = 4, @suma int = 0, @temp int = 1;


--while @temp <= @n
--begin
--	set @suma = @suma + @temp
--	set @temp = @temp + 1
--	print @suma
--end
--print @suma


---reszta z dzielenie
--zadanko - policzyć ile jest liczb parzystych w zakresie 1 do n

--declare @n int = 1, @liczy_parzyste int = 0, @zakres int = 10

--while @n <= @zakres
--begin
--	if @n%2 = 0
--		set @liczy_parzyste = @liczy_parzyste + 1
--	set @n = @n + 1
--end
--print @liczy_parzyste
