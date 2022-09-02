*&---------------------------------------------------------------------*
*& Report ZRSA20_40
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa20_40_top                           .    " Global Data

* INCLUDE ZRSA20_40_O01                           .  " PBO-Modules
* INCLUDE ZRSA20_40_I01                           .  " PAI-Modules
INCLUDE zrsa20_40_f01                           .  " FORM-Routines

INITIALIZATION.
  pa_majid = 'D220101'.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  SELECT *
    FROM ztsa20std
    INTO CORRESPONDING FIELDS OF TABLE gt_std
    WHERE majid = pa_majid.

  SELECT SINGLE *
    FROM ztsa20dep
    INTO CORRESPONDING FIELDS OF gs_dep
    WHERE majid = pa_majid.

  SELECT SINGLE mtext
    FROM ztsa20dep_t
    INTO CORRESPONDING FIELDS OF gs_dep
    WHERE majid = gs_std-majid.

  LOOP AT gt_std INTO gs_std.
    gs_std-majid = gs_dep-majid.
    gs_std-mtext = gs_dep-mtext.
    gs_std-colid = gs_dep-colid.
    CASE gs_std-colid.
      WHEN 'G01'.
        gs_std-ctext = '경상대'.
      WHEN 'G02'.
        gs_std-ctext = '공대'.
      WHEN 'G03'.
        gs_std-ctext = '사범대'.
      WHEN OTHERS.
        gs_std-ctext = '미정'.
    ENDCASE.

    CASE gs_std-gender.
      WHEN '1'.
        gs_std-gtext = '남성'.
      WHEN'2'.
        gs_std-gtext = '여성'.
      WHEN OTHERS.
        gs_std-gtext = '미정'.
    ENDCASE.

    MODIFY gt_std FROM gs_std.
    CLEAR gs_std.
  ENDLOOP.
  cl_demo_output=>display_data( gt_std ).
