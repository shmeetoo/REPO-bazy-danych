--procedura składniowa dzieląca num1 przez num2, jeśli num1 < num2 wygeneruj komunikat o błędzie

CREATE OR REPLACE PROCEDURE dzielenie(num1 FLOAT, num2 FLOAT)
LANGUAGE PLPGSQL
AS $$
DECLARE
	wynik FLOAT;
BEGIN
	IF num1 < num2 THEN 
		RAISE NOTICE 'Niewłaściwie zdefiniowałeś dane wejściowe!';
	ELSE 
		wynik = num1 / num2;
		RAISE NOTICE 'Wynik dzielenia % przez % = %', num1, num2, wynik;
	END IF;
	
END; $$;

CALL dzielenie(100,50);
CALL dzielenie(10,3);
CALL dzielenie(15,2);
CALL dzielenie(1,7);