--Napisać procedurę która będzie obniżać cenę aż średnia cena będzie mniejsza od podanej jako argument



drop procedure if exists ObnizycCeneSredniaOArgument
go
create procedure ObnizycCeneSredniaOArgument(@ArgumentObnizajacy float)
as
BeGIN
	print 'ArgumentObnizajacy'
	print @ArgumentObnizajacy
	declare @Procent float = 1
	declare @sredniaCena float = (select AVG(unitprice) from [Order Details])
	while @sredniaCena >= @ArgumentObnizajacy
		--print @sredniaCena

		begin
			--print @Procent
			set @sredniaCena = (select AVG(UnitPrice-(UnitPrice*@Procent/100)) from [Order Details])
			--print @sredniaCena
			--print @Procent
			set @Procent = @Procent + 1
		end
		print @Procent
		print @sredniaCena
END

exec ObnizycCeneSredniaOArgument 20