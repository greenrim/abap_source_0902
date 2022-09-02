*&---------------------------------------------------------------------*
*& Report ZRSA2090
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa2090_top                            .    " Global Data

INCLUDE zrsa2090_o01                            .  " PBO-Modules
INCLUDE zrsa2090_i01                            .  " PAI-Modules
INCLUDE zrsa2090_f01                            .  " FORM-Routines

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT. "PBO

AT SELECTION-SCREEN.        "PAI

START-OF-SELECTION.


  SELECT *
    FROM ztsa0099 "Vendor table
    INTO CORRESPONDING FIELDS OF TABLE gt_info
    WHERE carrid = pa_cid AND mealnumber IN so_meal.

  SELECT SINGLE *
FROM scarr
INTO CORRESPONDING FIELDS OF gs_subinfo
WHERE carrid = pa_cid.

  SELECT land1 landx50 AS land1_t
     FROM t005t
     INTO CORRESPONDING FIELDS OF TABLE gt_subinfo
     WHERE spras = sy-langu.

*
*  SELECT landx50 AS land1_t
*    FROM t005t
*    INTO CORRESPONDING FIELDS OF TABLE gt_subinfo
*    WHERE land1 = gt_info-land1
*    AND spras = sy-langu.

  LOOP AT gt_info INTO gs_info.

    READ TABLE gt_subinfo WITH KEY land1 = gs_info-land1 INTO gs_subinfo.
    gs_info-land1_t = gs_subinfo-land1_t.
    gs_info-carrname = gs_subinfo-carrname.

    MODIFY gt_info FROM gs_info.

  ENDLOOP.

  cl_demo_output=>display_data( gt_info ).
