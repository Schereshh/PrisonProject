-- Eltöltött idő
--     Miután törölnek egy rabot
--     berakja egy "prisoner_log" táblába, hogy
--     ki volt az, akit kiszabadítottak és hány évet ült

CREATE OR REPLACE TRIGGER timeSpent
    AFTER
        DELETE
    ON PRISONERS
    FOR EACH ROW
BEGIN
    INSERT INTO PRISONER_LOG VALUES(DEFAULT, :OLD.NAME, ROUND(((:OLD.TIME_OF_RELEASE - :OLD.TIME_OF_LOCK) / 365), 2));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Trigger error');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;
/