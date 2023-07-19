CREATE OR REPLACE PACKAGE BODY trc_app AS

    FUNCTION get_value_color (
        in_name         trc_lov_colors.name%TYPE,
        in_value        trc_lov_colors.treshold%TYPE,
        in_text         CHAR                            := NULL
    )
    RETURN trc_lov_colors.color_bg%TYPE
    AS
        out_color       trc_lov_colors.color_bg%TYPE;
    BEGIN
        -- check min value
        BEGIN
            SELECT CASE WHEN in_text IS NULL THEN t.color_bg ELSE t.color_text END INTO out_color
            FROM trc_lov_colors t
            WHERE 1 = 1
                AND t.name      = in_name
                AND t.treshold  <= in_value
                AND ROWNUM      = 1;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
        END;

        -- check max value
        BEGIN
            SELECT CASE WHEN in_text IS NULL THEN t.color_bg ELSE t.color_text END INTO out_color
            FROM trc_lov_colors t
            WHERE 1 = 1
                AND t.name      = in_name
                AND t.treshold  > in_value
                AND ROWNUM      = 1;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- value is above max treshold
            SELECT MIN(CASE WHEN in_text IS NULL THEN t.color_bg ELSE t.color_text END) KEEP (DENSE_RANK FIRST ORDER BY t.treshold DESC)
            INTO out_color
            FROM trc_lov_colors t
            WHERE t.name = in_name;
            --
            RETURN out_color;
        END;

        -- shortloop for text colors
        IF in_text IS NOT NULL THEN
            SELECT
                MIN(t.color_text) KEEP (DENSE_RANK FIRST ORDER BY t.treshold DESC)
            INTO out_color
            FROM trc_lov_colors t
            WHERE 1 = 1
                AND t.name      = in_name
                AND t.treshold  <= in_value;
            --
            RETURN out_color;
        END IF;

        -- calculate color in between
        WITH t AS (
            SELECT /*+ MATERIALIZE */
                t.left_treshold,
                t.right_treshold,
                in_value            AS value,
                (in_value - t.left_treshold) / (t.right_treshold - t.left_treshold) AS value_perc,
                --
                TO_NUMBER(SUBSTR(t.left_color,  2, 2), 'XX') AS left_r,
                TO_NUMBER(SUBSTR(t.left_color,  4, 2), 'XX') AS left_g,
                TO_NUMBER(SUBSTR(t.left_color,  6, 2), 'XX') AS left_b,
                TO_NUMBER(SUBSTR(t.right_color, 2, 2), 'XX') AS right_r,
                TO_NUMBER(SUBSTR(t.right_color, 4, 2), 'XX') AS right_g,
                TO_NUMBER(SUBSTR(t.right_color, 6, 2), 'XX') AS right_b
            FROM (
                SELECT
                    MIN(t.color_bg) KEEP (DENSE_RANK FIRST ORDER BY t.treshold DESC)    AS left_color,
                    MIN(t.treshold) KEEP (DENSE_RANK FIRST ORDER BY t.treshold DESC)    AS left_treshold,
                    MIN(r.color_bg) KEEP (DENSE_RANK FIRST ORDER BY r.treshold)         AS right_color,
                    MIN(r.treshold) KEEP (DENSE_RANK FIRST ORDER BY r.treshold)         AS right_treshold
                FROM trc_lov_colors t
                JOIN trc_lov_colors r
                    ON r.name       = t.name
                WHERE 1 = 1
                    AND t.name      = in_name
                    AND t.treshold  <= in_value
                    AND r.treshold  > in_value
            ) t
        )
        SELECT
            TO_CHAR(GREATEST(LEAST(ROUND((t.right_r - t.left_r) * t.value_perc + t.left_r, 0), 255), 0), 'FM0X') ||
            TO_CHAR(GREATEST(LEAST(ROUND((t.right_g - t.left_g) * t.value_perc + t.left_g, 0), 255), 0), 'FM0X') ||
            TO_CHAR(GREATEST(LEAST(ROUND((t.right_b - t.left_b) * t.value_perc + t.left_b, 0), 255), 0), 'FM0X')
        INTO out_color
        FROM t;
        --
        RETURN '#' || out_color;
    END;



    PROCEDURE init_headers
    AS
    BEGIN
        FOR i IN 0 .. 30 LOOP
            core.set_item('P100_HEADER_T' || LPAD(i, 2, '0'), REGEXP_REPLACE(TO_CHAR(TRUNC(SYSDATE) - i, 'Day, FMMonth ddth'), '\s+,', ','));
        END LOOP;
    END;



    PROCEDURE refresh_mv
    AS
    BEGIN
        FOR c IN (
            SELECT m.mview_name, SYSDATE AS start_at
            FROM all_mviews m
            WHERE m.owner           = SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA')
                AND m.mview_name    LIKE 'TRC%' ESCAPE '\'
            ORDER BY 1
        ) LOOP
            DBMS_MVIEW.REFRESH (
                list            => c.mview_name,
                method          => 'C',
                atomic_refresh  => FALSE
            );
        END LOOP;
    END;

END;
/

