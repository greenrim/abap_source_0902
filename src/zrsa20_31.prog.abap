*&---------------------------------------------------------------------*
*& Report ZRSA20_31
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa20_31_top                           .    " Global Data

* INCLUDE ZRSA20_31_O01                           .  " PBO-Modules
* INCLUDE ZRSA20_31_I01                           .  " PAI-Modules
INCLUDE zrsa20_31_f01                           .  " FORM-Routines

INITIALIZATION.
  PERFORM set_default.

START-OF-SELECTION.
  SELECT *
  FROM ztsa2001
  INTO CORRESPONDING FIELDS OF TABLE gt_emp
    WHERE entdt BETWEEN pa_ent_b AND pa_ent_e.
  IF sy-subrc IS NOT INITIAL.
    "MESSAGE i... "i는 그후 빠져나감
    RETURN. "return이 뭐였더라 이건 해당 블록을 빠져나가는거?
  ENDIF.

  SELECT *
    FROM ztsa20002
    INTO CORRESPONDING FIELDS OF TABLE gt_dep.

  LOOP AT gt_emp INTO gs_emp.
    CASE gs_emp-gender.
      WHEN 'M'.
        gs_emp-gender_t = '남성'.
      WHEN 'F'.
        gs_emp-gender_t = '여성'.
      WHEN OTHERS.
        gs_emp-gender_t = '미정'.
    ENDCASE.
    MODIFY gt_emp FROM gs_emp TRANSPORTING gender_t.
    CLEAR gs_emp.

  ENDLOOP.
  cl_demo_output=>display_data( gt_emp ).
  cl_demo_output=>display_data( gt_dep ).
