--utwórz funkcję, która zwraca numer karty dla konkretnego zamówienia

CREATE OR REPLACE FUNCTION numer_karty(id_zamowienia INT)
RETURNS VARCHAR(50)
LANGUAGE PLPGSQL
AS $$
DECLARE
	num_karty VARCHAR(50);
BEGIN
	SELECT sales.creditcard.cardnumber INTO num_karty 
	FROM sales.salesorderheader INNER JOIN sales.creditcard 
	ON sales.salesorderheader.creditcardid = sales.creditcard.creditcardid
	WHERE salesorderheader.salesorderid = id_zamowienia;
	
	RETURN num_karty;
END; $$;

SELECT * FROM numer_karty(43682);