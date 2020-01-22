---zadanko z kursowrem - liczymy średnią Unit prace ---

--declare kursor cursor for
--	select od.Quantity from [Order Details] od;
--	declare @quantity int, @quantitySum int = 0,
--	@n int = 1;
--	open kursor
--	fetch from kursor into @quantity
--	while @@FETCH_STATUS = 0
--	begin
--		set @quantitySum = @quantitySum + @quantity
--		set @n = @n + 1
--		fetch from kursor into @quantity
--	end
--	close kursor
--deallocate kursor
--declare @avg float =  @quantitySum / @n
--print @n
--print @quantitySum
--print @avg
--print @avg
declare kursor cursor for
	select od.UnitPrice from [Order Details] od;
	declare @UnitPrice int, @UnitPriceSum int = 0,
	@n int = 1;
	open kursor
	fetch from kursor into @UnitPrice
	while @@FETCH_STATUS = 0
	begin
		set @UnitPriceSum = @UnitPriceSum + @UnitPrice
		set @n = @n + 1
		fetch from kursor into @UnitPrice
	end
	close kursor
deallocate kursor
declare @avg float =  @UnitPriceSum / @n
print @n
print @UnitPriceSum
print @avg

