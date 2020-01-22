drop table if exists abc
go
create table abc 
(
id int identity (1,1),
abecadlo nvarchar(1)
);
insert into abc (abecadlo) values
('a'),
('b'),
('c')
select *
from abc
declare @i int = (select COUNT(1) from abc)
print @i
declare @n int = 1
declare @zdanie nvarchar(200) = ''
while @n <= @i
    begin
		declare @literka nvarchar(200) = ''
		if @zdanie not like ''
			set @literka = (select top(1) abecadlo from abc where abecadlo not like '['+@zdanie+']')
		else 
			set @literka = (select top(1) abecadlo from abc)
        print @literka
        set @zdanie = @zdanie +char(13)+char(10)+ @literka
        print @zdanie
        set @n  = @n+1
        print @n
    end
    Print @zdanie

--if @zdanie is not null or @zdanie not like ''
--	 declare @literka nvarchar(200) = (select top(1) abecadlo from abc)
--else 
--	set  @literka = (select top(1) abecadlo from abc where abecadlo not like '%'+@zdanie+'%')

--select top(1) abecadlo from abc where abecadlo not like '%'+'ab'+'%'
--select top(1) abecadlo from abc where abecadlo not like '[^'+'ab'+']'
--select top(1) abecadlo from abc where abecadlo not like '[a]'

