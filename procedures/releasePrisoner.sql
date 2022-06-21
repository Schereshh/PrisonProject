-- Szabadlábra helyezés
--     Amikor egy rabnak eljön a szabadulási ideje (time_of_release),
--     akkor az adatbázisból törölve lesz (ezt csak manuális megoldással lehet végrehajtani).
--     Ekkor a cellájában megürül egy hely és nem lesz már hozzárendelve egy őr sem.
--
-- Az eljárás paraméterei:
--     - Rab neve
--     - szabadulás dátuma
--
-- Ha a dátum előbb van, mint a szabadulási idő, akkor az eljárás dob egy hibaüzenetet

CREATE OR REPLACE PROCEDURE releasePrisoner(p_name VARCHAR2, p_curr_date VARCHAR2) IS
    p_prisoner_id  NUMBER;
    conv_curr_date DATE;
    p_release_date DATE;
    p_cell_id      NUMBER;
    p_capacity     NUMBER;
BEGIN
    -- Converts given date to date format
    conv_curr_date := TO_DATE(p_curr_date, 'YYYY-MM-DD');

    -- Gets the prisoner's ID and the time of his release
    SELECT ID, TIME_OF_RELEASE, CELL_ID
    INTO p_prisoner_id, p_release_date, p_cell_id
    FROM PRISONERS
    WHERE name = p_name;

    -- Checks if time was spent or not
    IF conv_curr_date < p_release_date THEN
        DBMS_OUTPUT.PUT_LINE('Time has not been spent yet!');
        RETURN;
    end if;

    -- Gets cell_id and capacity
    SELECT capacity
    INTO p_capacity
    FROM CELLS
    WHERE ID = p_cell_id;

    -- Increment capacity by 1
    UPDATE CELLS
    SET CAPACITY = (p_capacity + 1)
    WHERE ID = p_cell_id;

    DELETE
    FROM PRISONERS
    WHERE ID = p_prisoner_id;

    COMMIT;

EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No prisoner was found!');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unknown error occured!');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;
/

BEGIN
    releasePrisoner('Kiss Antal', '2050-06-19');
end;
/