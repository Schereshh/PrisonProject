-- Rab felvétel
--     Ezzel az eljárással rabokat küldhetünk bizonyos cellákba
--     Az eljárás paraméterei a következők lesznek:
--     - börtön rab neve
--     - az elkövetett bűncselekmény
-- Az eljárás automatikusan beosztja a rabot egy épületbe és egy cellába a bűncselekmény súlyossága alapján
-- (pl. emberölésért a C blokkba sorolják) és hozzárendelnek egy őrt, akinek a rabhoz megfelelő
-- "halálossági szintű" van

CREATE OR REPLACE PROCEDURE incarcerate(p_name VARCHAR2, p_crime VARCHAR2, p_lock_date VARCHAR2) IS
    p_crime_id     NUMBER;
    p_severity     NUMBER;
    conv_lock_date DATE;
    p_guard_id     NUMBER;
    p_cell_id      NUMBER;
    p_release_time DATE;
    p_capacity     NUMBER;
BEGIN
    -- Converts varchar2 date to date format
    conv_lock_date := TO_DATE(p_lock_date, 'YYYY-MM-DD');
    -- Checks for crime severity
    SELECT id, SEVERITY
    INTO p_crime_id, p_severity
    FROM CRIMES
    WHERE DESCRIPTION = p_crime;

    -- Look for appropriate guard
    IF p_severity = 1 THEN
        p_guard_id := pickGuard(1);
        IF p_guard_id IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('No corresponding guard was found');
            RETURN;
        end if;

        p_cell_id := pickCell(1);
        IF p_cell_id IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('No cells was available!');
            RETURN;
        end if;

        p_release_time := conv_lock_date + (365 * 2); -- Adds 2 years of jail time
    ELSIF p_severity = 2 THEN
        p_guard_id := pickGuard(2);
        IF p_guard_id IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('No corresponding guard was found');
            RETURN;
        end if;

        p_cell_id := pickCell(2);
        IF p_cell_id IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('No cells was available!');
            RETURN;
        end if;

        p_release_time := conv_lock_date + (365 * 5); -- Adds 5 years of jail time
    ELSIF p_severity = 3 THEN
        p_guard_id := pickGuard(3);
        IF p_guard_id IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('No corresponding guard was found');
            RETURN;
        end if;

        p_cell_id := pickCell(3);
        IF p_cell_id IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('No cells was available!');
            RETURN;
        end if;

        p_release_time := conv_lock_date + (365 * 12); --Adds 12 years of jail time
    end if;

    INSERT INTO PRISONERS values (DEFAULT, p_name, p_crime_id, p_cell_id, p_guard_id, p_release_time, conv_lock_date);
    -- Fetch the capacity of the cell
    SELECT CAPACITY
    INTO p_capacity
    FROM CELLS
    WHERE id = p_cell_id;
    -- Subtract one from it
    UPDATE CELLS
    SET CAPACITY = (p_capacity - 1)
    WHERE id = p_cell_id;

    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE(p_name || ' incarcerated for ' || p_crime);
    DBMS_OUTPUT.PUT_LINE('In cell: ' || p_cell_id);
    DBMS_OUTPUT.PUT_LINE('Guarded by: #' || p_guard_id);
    DBMS_OUTPUT.PUT_LINE('Time of lockdown: ' || TO_CHAR(conv_lock_date, 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Time of release: ' || TO_CHAR(p_release_time, 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
    COMMIT;

EXCEPTION
    WHEN no_data_found then
        DBMS_OUTPUT.PUT_LINE('Crime doesnt exist');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown error occured');
        ROLLBACK;
end;
/

-- Kiválasztja a súlyosság alapján a megfelelő őrt
CREATE OR REPLACE FUNCTION pickGuard(p_severity NUMBER)
    RETURN NUMBER IS
    f_guard_id NUMBER;
    num_of_guard NUMBER;
BEGIN
    -- Checks for all the guards with corresponding weapons
    FOR record IN (SELECT DISTINCT WS.LETHALITY_LEVEL, S.ID, S.NAME
                   FROM WEAPON_STORAGE,
                        STAFF S
                            JOIN WEAPON_STORAGE WS on WS.ID = S.WEAPON_ID
                   WHERE WS.LETHALITY_LEVEL = p_severity)
    LOOP
        -- Checks if guards is free (i. e. not assigned to any prisoners)
        SELECT COUNT(*)
        INTO num_of_guard
        FROM PRISONERS
        WHERE GUARD_ID = record.ID;

        IF num_of_guard = 0 THEN
            f_guard_id := record.ID;
            EXIT;
        end if;
    end loop;

    RETURN f_guard_id;
end;
/

CREATE OR REPLACE FUNCTION pickCell(p_severity NUMBER)
    RETURN NUMBER IS
    f_cell_id NUMBER;
BEGIN
    IF p_severity = 1 THEN
        SELECT id
        INTO f_cell_id
        FROM CELLS
        WHERE CELL_NAME LIKE 'A%' AND CAPACITY > 0
        FETCH FIRST ROW ONLY;
    ELSIF p_severity = 2 THEN
        SELECT id
        INTO f_cell_id
        FROM CELLS
        WHERE CELL_NAME LIKE 'B%' AND CAPACITY > 0
        FETCH FIRST ROW ONLY;
    ELSIF p_severity = 3 THEN
        SELECT id
        INTO f_cell_id
        FROM CELLS
        WHERE CELL_NAME LIKE 'C%' AND CAPACITY > 0
        FETCH FIRST ROW ONLY;
    end if;

    RETURN f_cell_id;
end;
/

BEGIN
    incarcerate('Kiss Antal', 'Kidnapping', '2022-06-21');
end;
/