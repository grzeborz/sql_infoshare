



use Northwind
go
create view orderCountByCity
as
select shipcity, COUNT(1) as widok from Orders
	group by Shipcity

	select * from orderCountByCity