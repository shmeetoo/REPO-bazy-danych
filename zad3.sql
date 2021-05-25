--utwórz procedurę, która przyjmuje nazwę produktu, a zwraca ID, numer, dostępność

CREATE OR REPLACE PROCEDURE dane_produktu (nazwa_produktu VARCHAR(20))
LANGUAGE PLPGSQL
AS $$
DECLARE
	id_produktu INT;
	numer_produktu VARCHAR(20);
	ilość INT;
BEGIN
	SELECT production.productinventory.productid, productnumber, quantity
	INTO id_produktu, numer_produktu, ilość
	FROM production.product INNER JOIN production.productinventory
	ON production.product.productid = production.productinventory.productid
	WHERE name = nazwa_produktu;
	
	RAISE NOTICE 'Dane produktu o nazwie "%":
	-ID: %
	-Numer: %
	-Ilość: %', nazwa_produktu, id_produktu, numer_produktu, ilość;
END; $$;

CALL dane_produktu('Down Tube');