--napisz procedurę, która przyjmuje NationalIDNumber, a zwraca stanowisko oraz liczbę dni urlopowych oraz chorobowych

CREATE OR REPLACE PROCEDURE info_pracownika(NationalID VARCHAR(15))
LANGUAGE PLPGSQL
AS $$
DECLARE
	id_krajowe VARCHAR(15);
	stanowisko VARCHAR(50);
	dni_urlopowe INT;
	dni_chorobowe INT;
BEGIN
	SELECT nationalidnumber, jobtitle, vacationhours / 24, sickleavehours / 24
	INTO id_krajowe, stanowisko, dni_urlopowe, dni_chorobowe
	FROM humanresources.employee
	WHERE employee.nationalidnumber = NationalID;
	
	RAISE NOTICE 'Pracownik o ID krajowym: %, pracujący na stanowisku: %, przebywał na urlopie % dni oraz chorował % dni.',
	id_krajowe, stanowisko, dni_urlopowe, dni_chorobowe;
END; $$;

CALL info_pracownika('295847284');
CALL info_pracownika('245797967');
CALL info_pracownika('134969118');
CALL info_pracownika('509647174');
CALL info_pracownika('879342154');
