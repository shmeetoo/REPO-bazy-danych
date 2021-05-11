CREATE SCHEMA Fibonacci;

CREATE OR REPLACE FUNCTION  Fibonacci.fibonacci(N INT)
RETURNS VOID
LANGUAGE PLPGSQL
AS $$
DECLARE
	pierwsza BIGINT;
	druga BIGINT;
	tmp BIGINT;
	i INT;
BEGIN
	pierwsza = 1;
	druga = 1;
	FOR i IN 3..N LOOP
		tmp = pierwsza + druga;
		pierwsza = druga;
		druga = tmp;
	END LOOP;
	RAISE NOTICE '% wyraz ciągu Fibonacciego wynosi: %', N, druga;
END; $$;

CREATE OR REPLACE PROCEDURE Fibonacci.ciag_fibonacciego(N INT)
LANGUAGE PLPGSQL
AS $$
BEGIN
	SELECT Fibonacci.fibonacci(N);
END; $$

CALL Fibonacci.ciag_fibonacciego(5);

