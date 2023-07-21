BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('trc_navigation'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM trc_navigation;
--
MERGE INTO trc_navigation t
USING (
    SELECT 0 AS page_id, NULL AS parent_id, NULL AS is_hidden, NULL AS is_reset, 666 AS order# FROM DUAL UNION ALL
    SELECT 100 AS page_id, NULL AS parent_id, NULL AS is_hidden, NULL AS is_reset, 100 AS order# FROM DUAL UNION ALL
    SELECT 800 AS page_id, NULL AS parent_id, NULL AS is_hidden, 'Y' AS is_reset, 800 AS order# FROM DUAL UNION ALL
    SELECT 9999 AS page_id, NULL AS parent_id, NULL AS is_hidden, NULL AS is_reset, 999 AS order# FROM DUAL
) s
ON (
    t.page_id = s.page_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.parent_id = s.parent_id,
--        t.is_hidden = s.is_hidden,
--        t.is_reset = s.is_reset,
--        t.order# = s.order#
WHEN NOT MATCHED THEN
    INSERT (
        t.page_id,
        t.parent_id,
        t.is_hidden,
        t.is_reset,
        t.order#
    )
    VALUES (
        s.page_id,
        s.parent_id,
        s.is_hidden,
        s.is_reset,
        s.order#
    );
