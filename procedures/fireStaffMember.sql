-- Elbocsájtás
--     A tárolt eljárás segítségével ki lehet rúgni egy alkalmazottat.
--     Megadjuk az illető nevét és ekkor az adatbáziból törlődik az az oszlop, ha pedig börtönőrről van szó,
--     akkor a fegyvere visszakerül a raktárba

CREATE OR REPLACE PROCEDURE fireStaff(p_name VARCHAR2) IS
    p_staff_id  NUMBER;
    p_weapon_id NUMBER;
    p_role_id   NUMBER;
    p_quantity  NUMBER;
BEGIN
    -- Prevents two staff firings at the same time
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    DBMS_LOCK.SLEEP(5);
    -- Getting staff ID from name
    SELECT id, role_id
    INTO p_staff_id, p_role_id
    FROM STAFF
    WHERE name = p_name;

    IF p_role_id = 1 THEN
        DBMS_OUTPUT.PUT_LINE('You cant fire a director');
        RETURN;
    end if;

    -- Checks if staff member is a guard
    IF p_role_id = 2 THEN
        -- Gets weapon ID which has to be put
        -- back into the storage
        SELECT WEAPON_ID
        INTO p_weapon_id
        FROM STAFF
        WHERE id = p_staff_id;

        IF p_weapon_id IS NOT NULL THEN
            -- Gets quantity of given weapon
            SELECT QUANTITY INTO p_quantity
            FROM WEAPON_STORAGE
            WHERE id = p_weapon_id;

            -- Increments weapon quantity by 1
            UPDATE WEAPON_STORAGE
            SET QUANTITY = (p_quantity + 1)
            WHERE id = p_weapon_id;
        end if;
    end if;

    DELETE
    FROM STAFF
    WHERE id = p_staff_id;

    COMMIT;

EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No staff member found');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('You cant fire an active guard');
        ROLLBACK;
end;
/

BEGIN
    fireStaff('Katók Ferenc');
end;
/