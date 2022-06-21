-- Staff felvétel
--     Ez az eljárás hozzáad az adatbázishoz új személyzeti tagot
--     Az eljárás paraméterei:
--         - a személyzeti tag neve
--         - az épület, amelybe be lesz osztva
--         - beosztása

CREATE OR REPLACE PROCEDURE addStaff(p_name VARCHAR2, p_building NUMBER, p_role VARCHAR2) IS
p_role_id NUMBER;
p_building_name VARCHAR2(200);
    begin
        -- Assigning the role ID with the given role name
        SELECT id
        INTO p_role_id
        FROM ROLES
        WHERE role = p_role;

        INSERT INTO STAFF values (DEFAULT, p_building, p_role_id, p_name, NULL);

        SELECT NAME
        INTO p_building_name
        FROM BUILDINGS
        WHERE p_building = id;

        DBMS_OUTPUT.PUT_LINE(p_name || ' assigned to ' || p_building_name || ' as ' || p_role);
        COMMIT;

        EXCEPTION
            WHEN no_data_found then
                DBMS_OUTPUT.PUT_LINE('Role doesnt exist');
                ROLLBACK;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('An unknown error occured');
                ROLLBACK;
    end;

BEGIN
    addStaff('Istenes Mátyás', 4, 'Guard');
end;

SELECT * FROM staff;