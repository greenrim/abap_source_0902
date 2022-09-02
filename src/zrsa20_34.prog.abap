*&---------------------------------------------------------------------*
*& Report ZRSA20_34
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_34.

"Dep Info
DATA gs_dep TYPE zssa2011.
DATA gt_dep LIKE TABLE OF gs_dep.

"Emp info (structure Variable)
DATA gs_emp LIKE LINE OF gs_dep-emp_list. "internal table을 이용해 structure변수 선언

PARAMETERS pa_dep TYPE ztsa0002-depid.

START-OF-SELECTION.

  SELECT SINGLE *
    FROM ztsa2002 "Dep Table
    INTO CORRESPONDING FIELDS OF gs_dep
    WHERE depid = pa_dep.
  "DTEXT는 TEXT TABLE에 있어서 DEPID와 PHONE만 들어감

  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  "Get Employee List
  SELECT *
    FROM ztsa2001 "Employee Table
    INTO CORRESPONDING FIELDS OF TABLE gs_dep-emp_list "Internal Table
  WHERE depid = gs_dep-depid.

  "성별 채우기
  LOOP AT gs_dep-emp_list INTO gs_emp.
    "Get gender Text

    MODIFY gs_dep-emp_list FROM gs_emp.
    CLEAR gs_emp.
  ENDLOOP.
