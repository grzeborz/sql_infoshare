--create index Products_name_index
--on Products(ProductName)

exec sp_helpindex Products;

---clustered index - znaczy że index jest porzadkuje tabelęi jest używany jako primary key