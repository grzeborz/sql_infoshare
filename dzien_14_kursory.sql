---zadanko - zagregować unitsinstock

--declare SumaUnitsInStock cursor for
--	select UnitsInStock from Products;
--	declare @aggrUIS int, @aggrSum int = 0;

--	open SumaUnitsInStock

--	fetch from SumaUnitsInStock into @aggrUIS

--	while @@FETCH_STATUS = 0
--		begin
--			set @aggrSum = @aggrSum + @aggrUIS
--			fetch from SumaUnitsInStock into @aggrUIS
--		end
--	close SumaUnitsInStock
--deallocate SumaUnitsInStock
--print @aggrSum

--select sum(UnitsInStock) from Products


----zadanko obliczyć VAT 
drop table if exists Przedmiot;
create table Przedmiot(
	id int identity(1,1) primary key,
	cena money,
	cenaBrutto money,
	typId int
)
drop table if exists TypPrzedmiotu;
create table TypPrzedmiotu(
	typId int identity(1,1) primary key,
	stawkaVat float
)
alter table Przedmiot
	add constraint FK_Produkt
		foreign key(typId) references TypPrzedmiotu(typId)

insert into TypPrzedmiotu (stawkaVat) values (23),(19),(30)
insert into Przedmiot (cena, typId) values (200, 2),(100,1),(300,3)


declare obliczamStawkeVat cursor for
				select cena, cenaBrutto, typId from Przedmiot;
				declare @Price money, @PriceBrutto money, @typid int, @stawkaVatZmienna float;
			open obliczamStawkeVat

			fetch from obliczamStawkeVat into @Price, @PriceBrutto, @typid

			while @@FETCH_STATUS = 0
				begin 
					set @stawkaVatZmienna = (select StawkaVat from TypProduktu where TypId =  @typid)
					set @PriceBrutto = @Price+(@Price * @stawkaVatZmienna/100)
					print 'Cena bazowa: '+convert(nvarchar(10),@Price)+' '+'Cena Brutto: '+ convert(nvarchar(10),@PriceBrutto) + ' '+'Typ produktu: '+ convert(nvarchar(10),@typid)
					fetch from obliczamStawkeVat into @Price, @PriceBrutto, @typid
				end
			close obliczamStawkeVat
deallocate obliczamStawkeVat