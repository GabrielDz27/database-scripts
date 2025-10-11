SELECT DBMS_RANDOM.NORMAL FROM DUAL;

DECLARE 
	VL_NUMERO_AL NUMBER; 
BEGIN 
   SELECT DBMS_RANDOM.NORMAL INTO VL_NUMERO_AL FROM DUAL;
	IF VL_NUMERO_AL = 0 THEN
		DBMS_OUTPUT.PUT_LINE('VALOR E ZERO : ' || VL_NUMERO_AL);
   ELSIF VL_NUMERO_AL > 0 THEN
		DBMS_OUTPUT.PUT_LINE('MAIOR QUE ZERO : ' || VL_NUMERO_AL);
   ELSE 
		DBMS_OUTPUT.PUT_LINE('MENOR QUE ZERO : ' || VL_NUMERO_AL);
   END IF;
END;

--
DECLARE /*AUMENTA*/
	VL NUMBER := 0.09;
	CURSOR C_EMPLOYEES IS SELECT * FROM EMPLOYEES;
	V_EMPLOYEES EMPLOYEES%ROWTYPE;
BEGIN
   UPDATE	EMPLOYEES 
   SET SALARY = SALARY * VL;

	FOR V_EMPLOYEES IN C_EMPLOYEES LOOP
        UPDATE	EMPLOYEES 
    	SET SALARY = (SALARY + (SALARY * VL))
        WHERE EMPLOYEE_ID = V_EMPLOYEES.EMPLOYEE_ID;
		DBMS_OUTPUT.PUT_LINE('SALARIO NORMAL: ' || (V_EMPLOYEES.SALARY + (V_EMPLOYEES.SALARY * VL)));
		DBMS_OUTPUT.PUT_LINE('AUMENTO: ' || V_EMPLOYEES.SALARY);
    END LOOP;
END;

--
DECLARE /*MOSTRANDO QUANTIDADES DE FUNCIONARIOS*/
	CURSOR C_EMPLOYEES_JOB IS SELECT DISTINCT JOB_ID FROM EMPLOYEES;
	-- V_JOB_ID EMPLOYEES.JOB_ID%TYPE;
	VL NUMBER;
BEGIN
	FOR V_JOB_ID IN C_EMPLOYEES_JOB LOOP
    	SELECT COUNT(*) INTO VL 
    	FROM EMPLOYEES 
    	WHERE JOB_ID = V_JOB_ID.JOB_ID;
    	IF VL > 3  THEN
			  DBMS_OUTPUT.PUT_LINE(' ' || V_JOB_ID.JOB_ID || ' : ' ||  VL);
        END IF;
    END LOOP;
END;

--
DECLARE /*INF DE FUNCIONARIOS*/
	CURSOR C_EMPLOYEES IS SELECT * FROM EMPLOYEES ORDER BY FIRST_NAME, LAST_NAME;
    -- V_EMPLOYEES EMPLOYEES%ROWTYPE;
BEGIN 
	FOR V_EMPLOYEES IN C_EMPLOYEES LOOP
		DBMS_OUTPUT.PUT_LINE( V_EMPLOYEES.FIRST_NAME || ' ' || V_EMPLOYEES.LAST_NAME || ', EMAIL:' || V_EMPLOYEES.EMAIL ||', DATA DE CONTRATAÇÃO:' || TO_DATE(V_EMPLOYEES.HIRE_DATE, 'YYYY-MM-DD'));
    END LOOP;
END;

-- Procedures

DECLARE /*minimo, maximo, medio*/
   a number;
   b number;
   c number;

    PROCEDURE valorMinimo(x IN number, y IN number, z OUT number) IS
    BEGIN
       IF x < y THEN
          z:= x;
       ELSE
          z:= y;
       END IF;
    END;

	PROCEDURE valorMaximo(x IN number, y IN number, z OUT number) IS
   BEGIN
      IF x > y THEN
         z:= x;
      ELSE
         z:= y;
      END IF;
   END;

	PROCEDURE valorMedio(x IN number, y IN number, z OUT number) IS
   BEGIN
      z := (x+y)/2;
   END;

BEGIN
   a:= 23;
   b:= 45;
   valorMinimo(a, b, c);
   dbms_output.put_line('O valor mínimo obtido entre os valores ' || a  || ' e ' || b || ' foi ' || c);
	valorMaximo(a, b, c);
   dbms_output.put_line('O valor maximo obtido entre os valores ' || a  || ' e ' || b || ' foi ' || c);
	valorMedio(a, b, c);
   dbms_output.put_line('O valor medio obtido entre os valores ' || a  || ' e ' || b || ' foi ' || c);
END;
