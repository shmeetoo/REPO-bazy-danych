--utwórz funkcję, która zwraca datę wysyłki określonego zamówienia

CREATE OR REPLACE FUNCTION data_wysylki (id_zamowienia INT)
RETURNS DATE
LANGUAGE PLPGSQL
AS $$
DECLARE
	data DATE;
BEGIN
	SELECT duedate INTO data FROM purchasing.purchaseorderdetail WHERE purchaseorderdetailid = id_zamowienia;
	RETURN data;
END; $$;

SELECT * FROM data_wysylki(69);