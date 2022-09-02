*&---------------------------------------------------------------------*
*& Report ZRSA20_32
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_32.

"Emp Info
*DATA gs_emp TYPE zssa2010.
DATA gs_emp TYPE zssa2005.
DATA gs_dep TYPE zssa2006.

PARAMETERS pa_pernr LIKE gs_emp-pernr.

INITIALIZATION.
  pa_pernr = '22020001'.

START-OF-SELECTION.
  SELECT SINGLE *
    FROM ztsa2001"Employee Table
    INTO CORRESPONDING FIELDS OF gs_emp
    WHERE pernr = pa_pernr.

*  IF sy-subrc IS INITIAL.                                 "=0.
*    cl_demo_output=>display_data( gs_emp ).
*  ELSE.                                                   "<>0.
*    MESSAGE i016(pn) WITH 'Data is not found!'.
*  ENDIF.

  IF sy-subrc <> 0.
    "Data is not found.
    MESSAGE i001(zmcsa20).
    RETURN.
  ENDIF.
*
*  WRITE gs_emp-depid.
*  WRITE gs_emp-dep-depid.

*  SELECT SINGLE *
*  FROM ztsa2002 "Dep Table
*  INTO gs_emp-dep
*    WHERE depid = gs_emp-depid.

  SELECT SINGLE *
  FROM ztsa2002 "Dep Table
  INTO gs_dep
    WHERE depid = gs_emp-depid.

*  cl_demo_output=>display_data( gs_emp ). "s안의 s는 이 문장 사용 못 함
*  cl_demo_output=>display_data( gs_emp-dep ).
