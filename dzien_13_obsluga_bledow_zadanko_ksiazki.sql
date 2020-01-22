
drop table if exists Klient;
create table Klient (
	id int identity(1,1) primary key,
	punkty int default 0 not null,
	klientMeno nvarchar(50) not null,
)

drop table if exists Ksiazka2;
create table Ksiazka2(
	ksiazkaId int identity(1,1) primary key,
	klientId int null)

insert into Ksiazka2 (klientId) values (1),
								(2),
								(3),
								(4)

insert into Klient (klientMeno) values ('zdzichu'),
								('tarzan'),
								('stefan'),
								('Zbigniew')

--drop table if exists Klient;
--create table Klient(
--klientid int identity (1,1) not null primary key,
--klientMeno nvarchar(50) not null,
--punkty int,
--ksiazkaId int foreign key references Ksiazka2(ksiazkaId)
--);
drop procedure if exists  wypozyczKsiazke;
go
create procedure wypozyczKsiazke(@klientId int, @ksiazkaId int)
as
begin
	if exists (select 1 from Klient k where k.id = @klientId)
		raiserror('klient %d nie istnieje', 16, 1, @klientId)
		begin
			begin try
			--print 'klient nie istnieje, id - ' + convert(nvarchar(5), @klientId);
			if exists (select 1 from Ksiazka2 k where k.ksiazkaId = @ksiazkaId)
			begin
				declare @wypKlientId int;
				set @wypKlientId = (select top 1 klientId from Ksiazka2 k where k.ksiazkaId = @ksiazkaId)
				if (@wypKlientId is null)
				begin
					update Ksiazka2 set klientId = @klientId where ksiazkaId = @ksiazkaId
					update Klient set punkty = punkty + 1 where id = @klientId
					print 'OK'
				end
				else
					raiserror('Ksiazka wypozyczona klientowi o id %d', 16, 1, @wypKlientId)
				--begin
				--	print 'Ksiazka wypozyczona klientowi o id ' + convert(nvarchar(5), @wypKlientId)
				--end
			end
			else
				raiserror('ksiazka nie istnieje, id -  %d ', 15, 3, @ksiazkaId)
			--begin
			--	print 'ksiazka nie istnieje, id - ' + convert(nvarchar(5), @ksiazkaId);
			--end
		end
	else
	raiserror('klient nie istnieje, id - %d', 15, 3, klientId)
		--begin
		--	print 'klient nie istnieje, id - ' + convert(nvarchar(5), @klientId);
		--end
	end try
	begin catch
		if (@@TRANCOUNT > 0) 
		begin
			rollback
			print 'rollback'
		end
		declare @msg nvarchar(100) = error_message();
		declare @state int = error_state()
		declare @error_severity int = error_severity()	
		raiserror(@msg, @error_severity, @state)
	end catch
	if (@@TRANCOUNT > 0)
		commit
end

exec dbo.wypozyczKsiazke @klientId =1, @ksiazkaId=1

--drop procedure if exists  wypozyczKsiazke;
--go
--create procedure wypozyczKsiazke(@klientId int, @ksiazkaId int)
--as
--begin
--	if exists (select 1 from Klient k where k.id = @klientId)
--	begin
--		print 'klient nie istnieje, id - ' + convert(nvarchar(5), @klientId);
--		if exists (select 1 from Ksiazka2 k where k.ksiazkaId = @ksiazkaId)
--		begin
--			declare @wypKlientId int;
--			set @wypKlientId = (select top 1 klientId from Ksiazka2 k where k.ksiazkaId = @ksiazkaId)
--			if (@wypKlientId is null)
--			begin
--				update Ksiazka2 set klientId = @klientId where ksiazkaId = @ksiazkaId
--				update Klient set punkty = punkty + 1 where id = @klientId
--				print 'OK'
--			end
--			else
--			begin
--				print 'Ksiazka wypozyczona klientowi o id ' + convert(nvarchar(5), @wypKlientId)
--			end
--		end
--		else
--		begin
--			print 'ksiazka nie istnieje, id - ' + convert(nvarchar(5), @ksiazkaId);
--		end
--	end
--	else
--	begin
--		print 'klient nie istnieje, id - ' + convert(nvarchar(5), @klientId);
--	end
--end