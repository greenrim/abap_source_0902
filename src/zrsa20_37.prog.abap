*&---------------------------------------------------------------------*
*& Report ZRSA20_37
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_37.

DATA: gs_info TYPE zvsa2003, "Database View
      gt_info LIKE TABLE OF gs_info.

*PARAMETERS pa_dep LIKE gs_info-depid.

START-OF-SELECTION.

*LEFT OUTER JOIN
  SELECT *
    FROM ztsa2001 AS emp LEFT OUTER JOIN ztsa2002 AS dep
    ON emp~depid = dep~depid
    INTO CORRESPONDING FIELDS OF TABLE gt_info.

**LEFT OUTER JOIN
*  SELECT *
*    FROM ztsa2002 AS dep LEFT OUTER JOIN ztsa2001 AS emp
*    ON dep~depid = emp~depid
*    INTO CORRESPONDING FIELDS OF TABLE gt_info.

**OPEN SQL INNER JOIN3
*SELECT *
*  FROM ztsa2001 as emp inner join ztsa2002 as dep
*  on emp~depid = dep~depid
*  into CORRESPONDING FIELDS OF table gt_info.

**OPEN SQL INNER JOIN 문법2
*  SELECT a~pernr a~ename a~depid b~phone
*    FROM ztsa2001 AS a INNER JOIN ztsa2002 AS b
*    ON a~depid = b~depid
*    INTO CORRESPONDING FIELDS OF TABLE gt_info
*    WHERE a~depid = pa_dep.

**OPEN SQL INNER JOIN 문법1
*  SELECT *
*    FROM ztsa2001 INNER JOIN ztsa2002
*      ON ztsa2001~depid = ztsa2002~depid
*    INTO CORRESPONDING FIELDS OF TABLE gt_info
*  WHERE ztsa2001~depid = pa_dep.

*  SELECT *
*    FROM zvsa2003 "Database View
*    INTO CORRESPONDING FIELDS OF TABLE gt_info.
**    WHERE depid = pa_dep.

  cl_demo_output=>display_data( gt_info ).
