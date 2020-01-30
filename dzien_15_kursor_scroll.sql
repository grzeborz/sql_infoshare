/*********************
Drugą największą Drugą największą Drugą największą UnitPrice UnitPrice
***********************/

go
declare biggestprice scroll cursor for
						select UnitPrice from Products order by UnitPrice asc
	declare @biggestshot money;

	open biggestprice

	fetch last from biggestprice into @biggestshot

	print 'twoj najwiekszy strzal to: '+convert(nvarchar(20), @biggestshot)

	fetch prior from biggestprice into @biggestshot

	print 'druga najwieksza to: '+convert(nvarchar(20), @biggestshot)

	fetch relative -2 from biggestprice into @biggestshot

	print @biggestshot

	fetch relative 2 from biggestprice into @biggestshot

	print @biggestshot

	fetch relative -4 from biggestprice into @biggestshot

	print 'czwarta najwieksza to: '+convert(nvarchar(20), @biggestshot)

	close biggestprice

	deallocate biggestprice;


/***************************************
	----zadanko -4 od końca 4 od końca UnitPrice UnitPrice
***************************************/
go	
declare biggestprice scroll cursor for
						select UnitPrice from Products order by UnitPrice asc
	declare @biggestshot money;

	open biggestprice

	--fetch last from biggestprice into @biggestshot

	--print 'twoj najwiekszy strzal to: '+convert(nvarchar(20), @biggestshot)

	fetch absolute -4 from biggestprice into @biggestshot


	print 'czwarta od końca to: '+convert(nvarchar(20), @biggestshot)

	close biggestprice

	deallocate biggestprice