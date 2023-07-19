CREATE OR REPLACE FORCE VIEW trc_color_preview_v AS
WITH c AS (
    SELECT /*+ MATERIALIZE */
        c.*,
        ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY c.treshold) AS r#
    FROM trc_lov_colors c
)
SELECT
    c.name,
    --
    MAX(CASE WHEN c.r# = 1  THEN c.treshold END) AS c01,
    MAX(CASE WHEN c.r# = 2  THEN c.treshold END) AS c02,
    MAX(CASE WHEN c.r# = 3  THEN c.treshold END) AS c03,
    MAX(CASE WHEN c.r# = 4  THEN c.treshold END) AS c04,
    MAX(CASE WHEN c.r# = 5  THEN c.treshold END) AS c05,
    MAX(CASE WHEN c.r# = 6  THEN c.treshold END) AS c06,
    MAX(CASE WHEN c.r# = 7  THEN c.treshold END) AS c07,
    MAX(CASE WHEN c.r# = 8  THEN c.treshold END) AS c08,
    MAX(CASE WHEN c.r# = 9  THEN c.treshold END) AS c09,
    MAX(CASE WHEN c.r# = 10 THEN c.treshold END) AS c10,
    --
    MAX(CASE WHEN c.r# = 1  THEN trc_app.get_value_color(c.name, c.treshold) END)       AS c01_color,
    MAX(CASE WHEN c.r# = 2  THEN trc_app.get_value_color(c.name, c.treshold) END)       AS c02_color,
    MAX(CASE WHEN c.r# = 3  THEN trc_app.get_value_color(c.name, c.treshold) END)       AS c03_color,
    MAX(CASE WHEN c.r# = 4  THEN trc_app.get_value_color(c.name, c.treshold) END)       AS c04_color,
    MAX(CASE WHEN c.r# = 5  THEN trc_app.get_value_color(c.name, c.treshold) END)       AS c05_color,
    MAX(CASE WHEN c.r# = 6  THEN trc_app.get_value_color(c.name, c.treshold) END)       AS c06_color,
    MAX(CASE WHEN c.r# = 7  THEN trc_app.get_value_color(c.name, c.treshold) END)       AS c07_color,
    MAX(CASE WHEN c.r# = 8  THEN trc_app.get_value_color(c.name, c.treshold) END)       AS c08_color,
    MAX(CASE WHEN c.r# = 9  THEN trc_app.get_value_color(c.name, c.treshold) END)       AS c09_color,
    MAX(CASE WHEN c.r# = 10 THEN trc_app.get_value_color(c.name, c.treshold) END)       AS c10_color,
    --
    MAX(CASE WHEN c.r# = 1  THEN trc_app.get_value_color(c.name, c.treshold, 'Y') END)  AS c01_text,
    MAX(CASE WHEN c.r# = 2  THEN trc_app.get_value_color(c.name, c.treshold, 'Y') END)  AS c02_text,
    MAX(CASE WHEN c.r# = 3  THEN trc_app.get_value_color(c.name, c.treshold, 'Y') END)  AS c03_text,
    MAX(CASE WHEN c.r# = 4  THEN trc_app.get_value_color(c.name, c.treshold, 'Y') END)  AS c04_text,
    MAX(CASE WHEN c.r# = 5  THEN trc_app.get_value_color(c.name, c.treshold, 'Y') END)  AS c05_text,
    MAX(CASE WHEN c.r# = 6  THEN trc_app.get_value_color(c.name, c.treshold, 'Y') END)  AS c06_text,
    MAX(CASE WHEN c.r# = 7  THEN trc_app.get_value_color(c.name, c.treshold, 'Y') END)  AS c07_text,
    MAX(CASE WHEN c.r# = 8  THEN trc_app.get_value_color(c.name, c.treshold, 'Y') END)  AS c08_text,
    MAX(CASE WHEN c.r# = 9  THEN trc_app.get_value_color(c.name, c.treshold, 'Y') END)  AS c09_text,
    MAX(CASE WHEN c.r# = 10 THEN trc_app.get_value_color(c.name, c.treshold, 'Y') END)  AS c10_text
    --
FROM c
GROUP BY
    c.name;
--
COMMENT ON TABLE trc_color_preview_v IS '';

