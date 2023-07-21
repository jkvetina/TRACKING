BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('trc_lov_colors'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM trc_lov_colors;
--
MERGE INTO trc_lov_colors t
USING (
    SELECT 'COLOR_ACTIVITY' AS name, 0 AS treshold, '#508104' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_ACTIVITY' AS name, 10 AS treshold, '#9e8e01' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_ACTIVITY' AS name, 20 AS treshold, '#f3b800' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_ACTIVITY' AS name, 50 AS treshold, '#db8200' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_ACTIVITY' AS name, 100 AS treshold, '#b64201' AS color_bg, '#ffffff' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_TIME' AS name, 0 AS treshold, '#508104' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_TIME' AS name, 0.5 AS treshold, '#9e8e01' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_TIME' AS name, 1 AS treshold, '#f3b800' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_TIME' AS name, 1.5 AS treshold, '#db8200' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_TIME' AS name, 2 AS treshold, '#b64201' AS color_bg, '#ffffff' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS' AS name, 1 AS treshold, '#4e7779' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS' AS name, 2 AS treshold, '#90c7ca' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS' AS name, 5 AS treshold, '#c3ba9b' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS' AS name, 10 AS treshold, '#7e6d53' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS_ALT1' AS name, 1 AS treshold, '#235f83' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS_ALT1' AS name, 2 AS treshold, '#8eb3aa' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS_ALT1' AS name, 3 AS treshold, '#e9cf87' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS_ALT1' AS name, 5 AS treshold, '#a2885e' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS_ALT2' AS name, 1 AS treshold, '#bbcfd7' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS_ALT2' AS name, 2 AS treshold, '#d2c8bc' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS_ALT2' AS name, 5 AS treshold, '#ba9a88' AS color_bg, '#000000' AS color_text FROM DUAL UNION ALL
    SELECT 'COLOR_USERS_ALT2' AS name, 10 AS treshold, '#ac7e62' AS color_bg, '#000000' AS color_text FROM DUAL
) s
ON (
    t.name = s.name
    AND t.treshold = s.treshold
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.color_bg = s.color_bg,
--        t.color_text = s.color_text
WHEN NOT MATCHED THEN
    INSERT (
        t.name,
        t.treshold,
        t.color_bg,
        t.color_text
    )
    VALUES (
        s.name,
        s.treshold,
        s.color_bg,
        s.color_text
    );
