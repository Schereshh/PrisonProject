-- Fegyver kiosztás
--     A tárolt eljárás egy fegyvert rendel hozzá egy bizonyos személyzeti taghoz (KIZÁRÓLAG BÖRTÖNŐRHÖZ).
--     A raktárban levő fegyvereknek van egy "halálossági szintje". Minél halálosabb fegyvert birtokol egy őr,
--     annál veszélyesebb rabokhoz lehet hozzárendelni
--     Pl. ha egy rab bűncselekményének a súlyossági szintje 3, akkor oda csak 3-as halálossági szintű
--     fegyveres őrt lehet hozzárendelni
--
--     Az eljárás paraméterei:
--         - az őr neve
--         - a fegyver halálossági szintje

CREATE OR REPLACE PROCEDURE assignWeaponSingle(p_name VARCHAR2, p_lethality NUMBER) IS
    p_weapon_id  NUMBER;
    p_role_check NUMBER;
    weapon_found BOOLEAN;
    p_quantity   NUMBER;
BEGIN
    weapon_found := false;
    --Check if the given name is a guard
    SELECT role_id
    INTO p_role_check
    FROM STAFF
    WHERE p_name = name;

    IF p_role_check = 2 THEN

        --Checks if lethality level exists
        IF NOT (p_lethality < 1 or p_lethality > 3) THEN
            -- For loop looks for first available weapon ID in the category
            FOR record IN (SELECT * FROM WEAPON_STORAGE WHERE p_lethality = LETHALITY_LEVEL)
                LOOP
                    IF record.QUANTITY > 0 THEN
                        p_weapon_id := record.ID;
                        weapon_found := true;
                        EXIT;
                    end if;
                END LOOP;

            -- Checks if weapon was found or not
            IF weapon_found = true THEN
                --Assign weapon to staff member
                UPDATE staff
                SET WEAPON_ID = p_weapon_id
                WHERE name = p_name;

                --Subtract one from the value
                SELECT QUANTITY
                INTO p_quantity
                FROM WEAPON_STORAGE
                WHERE id = p_weapon_id;

                UPDATE WEAPON_STORAGE
                SET QUANTITY = (p_quantity - 1)
                WHERE id = p_weapon_id;

                COMMIT;
            ELSE
                DBMS_OUTPUT.PUT_LINE('No available weapon was found');
            end if;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Lethality doesnt exist');
        end if;
    ELSE
        --If it's not a guard, exits.
        DBMS_OUTPUT.PUT_LINE('Only guards can be equipped with a weapon!');
    end if;

EXCEPTION
    WHEN no_data_found then
        DBMS_OUTPUT.PUT_LINE('The guard doesnt exist');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unknown error occured!');
end;

BEGIN
    assignWeaponSingle('Pityi Palkó', 3);
end;



