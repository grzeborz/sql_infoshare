/**********************************
Napisać trigger który podczas usuwania wiersza z Order Details , 
wpiszę jego wartość do tabeli Order Details History
***********************************/
go
drop trigger if exists triggerDeletedOrderDetails;
go
create trigger triggerDeletedOrderDetails
on [Order Details]
for delete
as
	begin
		declare @usunietyID nvarchar(20)
		declare @ProdID nvarchar(20)
		select top 1 @usunietyID = OrderId,@ProdID= ProductID
				from deleted;
		print '*****UWAGA*****'+char(10)+
		'Usunieto z tabeli wiersze o numerze ObjectID: '+ convert(nvarchar(10),@usunietyID)
		+' oraz produkt o numerze ProductID: '+convert(nvarchar(10),@ProdID)+char(10)+
		'*****UWAGA*****'
		--print @ProdID
	end

delete from [Order Details] where OrderID = 10254 and ProductID = 24

select * from [Order Details]
drop table if exists OrderDetailsHistory;
create table OrderDetailsHistory(
	historyID int identity(1,1),
	orderId int,
	productId int, 
	unitPrice money,
	quantity int, 
	discout real)

/***********
z uzyciem kursora
************/
go
drop trigger if exists triggerDeletedOrderDetails;
go
create trigger triggerDeletedOrderDetails
on [Order Details]
for delete
as
	begin
		--declare @usunietyID nvarchar(20)
		--declare @ProdID nvarchar(20),  @unitprice money,
		--@quantity int, @discount int;
		--select top 1 @usunietyID = OrderId, @ProdID= ProductID, @unitprice = unitprice,
		--@quantity = quantity, @discount = discount;
		--		from deleted;
		--print '*****UWAGA*****'+char(10)+
		--'Usunieto z tabeli wiersze o numerze ObjectID: '+ convert(nvarchar(10),@usunietyID)
		--+' oraz produkt o numerze ProductID: '+convert(nvarchar(10),@ProdID)+char(10)+
		--'*****UWAGA*****'


	    insert into OrderDetailsHistory(orderId, productId, unitPrice, quantity, discout)
			(select d.OrderID, d.ProductID, d.UnitPrice, d.Quantity, d.Discount from deleted d)	
		--values (@usunietyID, @ProdID, @unitprice,@quantity, @discount)
		--print @ProdID
	end

delete from [Order Details] where OrderID = 10254 and ProductID = 24

select * from [Order Details]