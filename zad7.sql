--kalkulator walutowy

CREATE OR REPLACE PROCEDURE kalkulator(kwota FLOAT, waluta_przed CHAR(3), waluta_po CHAR(3), data DATE)
LANGUAGE PLPGSQL
AS $$
DECLARE
	waluta CHAR(3);
	kurs FLOAT;
	nowa_kwota FLOAT;
BEGIN
	IF (waluta_przed != 'USD') AND (waluta_po != 'USD') THEN
		RAISE EXCEPTION 'Podałeś złe waluty!';
	END IF;

	IF (waluta_przed = 'USD') THEN
		waluta = waluta_po;
	ELSE
		waluta = waluta_przed;
	END IF;

	SELECT averagerate INTO kurs
	FROM sales.currencyrate
	WHERE tocurrencycode = waluta AND currencyratedate = data;

	IF (waluta_przed != 'USD') THEN
		kurs = 1/kurs;
	END IF;
	
	RAISE NOTICE 'Kurs = %', kurs;
	nowa_kwota = kwota * kurs;
	RAISE NOTICE '% % = % %
	', kwota, waluta_przed, nowa_kwota, waluta_po;

END; $$;

CALL kalkulator(100,'USD','EUR','2011-05-31 00:00:00');
CALL kalkulator(96.97,'EUR','USD','2011-05-31 00:00:00');
CALL kalkulator(100,'USD','JPY','2011-05-31 00:00:00');
CALL kalkulator(10491,'JPY','USD','2011-05-31 00:00:00');
CALL kalkulator(100,'GBP','FRF','2011-05-31 00:00:00');


--nie ma PLN w sales.currencyrate :(
SELECT * FROM sales.currencyrate WHERE tocurrencycode = 'PLN';
