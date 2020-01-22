---- Zadanko z transakcjami ----
drop table if exists Cust;
go
create table Cust
(
id int identity(1,1) primary key,
kontoID int foreign key references Konto(kontoid)
);

drop table if exists Konto;
go
create table Konto
(
kontoID int identity(1,1) primary key,
saldo money not null default 0
);

insert into Cust(kontoID)values(2)

insert into Konto(saldo)values(20)



drop procedure if exists dbo.przelew;
go
create procedure dbo.przelew(@kwota money, @custID1 int, @CustId2 int)
as
	Begin
		--
		begin try
			begin transaction
				if not exists (select 1 from Cust where id = @custID1)
					raiserror('klient %d nie istnieje', 16, 1, @custId1)

				if not exists (select 1 from Cust where id = @CustId2)
					raiserror('klient %d nie istnieje', 16, 1, @custId2)

				declare @kontoCustId int = (select top (1) k.kontoID 
												from Konto k 
												join Cust c on k.kontoid = c.kontoid
													where c.id=@custID1)

				if (@kontoCustId is null)
					raiserror('Klient o id %d nie ma konta', 15, 3, @custID2)

				declare @saldoCust1 money = (select top 1 saldo 
												from Konto k 
												join Cust c on k.kontoid = c.kontoid
													where c.id=@custID1)

				if (@saldoCust1<@kwota)
					raiserror('klinet %d spłukany', 15, 3, @custID1)

				update Konto set saldo = saldo + @kwota where kontoID = @CustId2
				update Konto set saldo = saldo 1 @kwota where kontoID = @CustId1

		end try
		begin catch
			print error_number()
			print error_state()
			if (@@TRANCOUNT > 0)
			begin
				rollback
				print 'rollback'
			end
			declare @msg nvarchar(100) = error_message();
			declare @state int = error_state();
			declare @error_severity int = error_severity();
			raiserror
		end catch
		if (@@TRANCOUNT > 0)
			commit

		--


	end

	exec dbo.przelew @kwota = 100, @custid1 = 1, @custid2 = 2