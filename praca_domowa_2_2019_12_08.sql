--Zadanie 1
--Zadeklarować zmienną x z wartością 7. Dodać do niej 3, następnie przemnozyc przez 3 i wypisać poleniem print.

--declare @x int =7;
--set @x = @x+3;
--set @x = @x*3
--print @x
--Zadanie 2 
--Wypisać pętla while liczby o 1 do n gdzie n jest zmienną.
--declare @n int =1;
--while @n < 10
--	begin
--	PRINT convert(nvarchar(5), @n)
--		set @n = @n + 1
--	end
--Zadanie 3 
--Wypisać sumę kwadratow liczb od 1 do n tzn
--Np dla liczny n równej 3 było było to
--1*1+2*2+3*3 Czyli 14

declare @n int =1;
declare @m int =1;
declare @i int =3;
declare @s int = 0;

while @s <= @i
	begin
	PRINT convert(nvarchar(5), @n)
		set @m = @s * @s
	PRINT convert(nvarchar(5), @m)
		set @n = @n + @m
		set @s = @s + 1
	end
print 'wynik to ='+convert(nvarchar(5), @n)