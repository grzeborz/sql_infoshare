/*****************************************8
zadanko tableka faktury
pole faktury, miesiąc, rok, orderId, łączna_Cena_Zamówienia


cena dla zamówienia musi być pogrupowana

*****************************************/
use northwind
go
drop table if exists tabelaFakturowa;
create table tabelaFakturowa
(
id int,
mies int,
rok int,
orderid int primary key not null,
lacznaCenaZamowienia money not null
)

select * from tabelaFakturowa;

declare populationoftheTaxTable cursor for
					select ROW_NUMBER() over
							(partition by year(orderdate), month(orderdate) 
							order by year(orderdate), month(orderdate)) as Nr,
							 month(orderdate), year(orderdate),o.OrderID,
							 SUM(Quantity*UnitPrice*(1-Discount)) as kosztFakturki
					from Orders o left join [Order Details] od on o.OrderID = od.OrderID
					group by month(orderdate),year(orderdate), o.OrderID--, SUM(Quantity*UnitPrice)

					declare @Nr int, @orderID int, @miesiac int, @rok int, @wartosc money

					open populationoftheTaxTable

					fetch from populationoftheTaxTable into @Nr, @miesiac, @rok,@orderID, @wartosc

					while @@FETCH_STATUS = 0

						begin
							insert into tabelaFakturowa (id ,mies,rok,orderid,lacznaCenaZamowienia)
										values(@Nr, @miesiac,@rok, @orderID, @wartosc)
							--update tabelaFakturowa set id = @Nr, 
							--						mies = @miesiac, 
							--						rok = rok,
							--						orderid = @orderID,
							--						lacznaCenaZamowienia = @wartosc
							fetch from populationoftheTaxTable into @Nr, @miesiac, @rok,@orderID, @wartosc
						end
					close populationoftheTaxTable
				deallocate populationoftheTaxTable

select * from tabelaFakturowa;

					--select * from Orders o left join [Order Details] od on o.OrderID = od.OrderID