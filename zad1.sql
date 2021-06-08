--blok anonimowy, który znajduje średnią stawkę oraz wyświetla pracowników których stawka jest mniejsza od średniej

DO $$
DECLARE
	średnia_stawka NUMERIC;
	imie VARCHAR(50);
	nazwisko VARCHAR(50);
	stanowisko VARCHAR(50);
	stawka NUMERIC;
BEGIN
	SELECT avg(rate) INTO średnia_stawka
	FROM humanresources.employee 
	INNER JOIN humanresources.employeepayhistory
	ON employee.businessentityid = employeepayhistory.businessentityid;
	
	RAISE NOTICE 'Średnia stawka = %', średnia_stawka;

	SELECT person.firstname, person.lastname, employee.jobtitle, employeepayhistory.rate
	INTO imie, nazwisko, stanowisko, stawka
	FROM humanresources.employee
	INNER JOIN humanresources.employeepayhistory ON employee.businessentityid = employeepayhistory.businessentityid
	INNER JOIN person.person ON employee.businessentityid = person.businessentityid
	WHERE rate < średnia_stawka ORDER BY rate;
	
	RAISE NOTICE '% %, %, stawka: %', imie, nazwisko, stanowisko, stawka;
	
END; $$;

