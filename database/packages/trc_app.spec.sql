CREATE OR REPLACE PACKAGE trc_app AS

    FUNCTION get_value_color (
        in_name         trc_lov_colors.name%TYPE,
        in_value        trc_lov_colors.treshold%TYPE,
        in_text         CHAR                            := NULL
    )
    RETURN trc_lov_colors.color_bg%TYPE;

END;
/

