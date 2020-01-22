---

declare OrderIdKursor cursor for
	select OrderID, sum(Quantity) 
		from [Order Details]
			group by OrderID
			order by OrderID;
	declare @quantity int, @quantitySum int = 0,
	@orderID int;
	open OrderIdKursor
	fetch from OrderIdKursor into @orderID, @quantity
	while @@FETCH_STATUS = 0
	begin
		set @quantitySum = @quantitySum + @quantity
		set @orderID = @orderID
		print 'Oderid'+' '+convert(nvarchar(10),@orderID) +' '+ convert(nvarchar(10),@quantitySum)
		fetch from OrderIdKursor into @orderID, @quantity
	end
	--print @orderID  convert(nvarchar(5), @klientId)
	close OrderIdKursor
	--print @orderID
deallocate OrderIdKursor
--print @quantitySum
