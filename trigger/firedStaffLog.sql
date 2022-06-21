-- Kirúgott alkalmazott
--     Ez a trigger alkalmazott kirúgása után
--     egy "staff_log" táblába rakja az alkalmazott nevét,
--     foglalkozását és azt, hogy mikor bocsájtották el

CREATE OR REPLACE TRIGGER firedStaffMember
    AFTER
        DELETE
    ON STAFF
    FOR EACH ROW
DECLARE
    role_name VARCHAR2(10);
BEGIN
    SELECT ROLE INTO role_name
    FROM ROLES
    WHERE ID = :OLD.ROLE_ID;

    INSERT INTO STAFF_LOG
    VALUES(DEFAULT, :OLD.NAME, role_name, TO_DATE(SYSDATE, 'YY-MM-DD'));

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Trigger error');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;
/

SELECT DISTINCT R.ROLE, S.NAME, TO_DATE(SYSDATE, 'YY-MM-DD')
FROM STAFF S, ROLES R JOIN STAFF S2 on R.ID = S2.ROLE_ID
WHERE R.ID = S.ROLE_ID AND S.ID = 2;

SELECT DISTINCT R.ROLE, S.NAME, TO_DATE(SYSDATE, 'YY-MM-DD')
FROM STAFF S, ROLES R JOIN STAFF S2 on R.ID = S2.ROLE_ID
WHERE R.ID = S.ROLE_ID;