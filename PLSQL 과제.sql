-- 1.
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
        INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE( E.EMP_NAME ||', '||(E.SALARY+E.SALARY*NVL(E.BONUS, 0))*12);
    
END;
/

--2.
DECLARE
BEGIN
    FOR I IN 2..9
    LOOP
    IF MOD(I,2) = 0
        THEN
         FOR J IN 1..9
            LOOP
            DBMS_OUTPUT.PUT_LINE(I||'X'||J||'='||I*J);
        END LOOP;
            DBMS_OUTPUT.PUT_LINE('------------------------');
        END IF;
    END LOOP;
END;
/

DECLARE
    I NUMBER := 2;
    J NUMBER := 1;
BEGIN
    WHILE I <= 9
    LOOP
        J := 1;
        IF MOD(I,2)=0
         THEN
            WHILE J <= 9
            LOOP
                DBMS_OUTPUT.PUT_LINE(I||'X'||J||'='||I*J);
                J := J+1;
            END LOOP;
                DBMS_OUTPUT.PUT_LINE('-------------------------');
        END IF;
        I := I+1;
    END LOOP;
END;
/

SELECT * FROM USER_SEQUENCES;