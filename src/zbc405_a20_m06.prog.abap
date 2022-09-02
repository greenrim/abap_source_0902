*&---------------------------------------------------------------------*
*& Report ZBC405_A20_M06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_m06_top                      .    " Global Data

* INCLUDE ZBC405_A20_M06_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A20_M06_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A20_M06_F01                      .  " FORM-Routines

"select single
*SELECT SINGLE PERNR GENDER
*  FROM ztsa2001
*  INTO ( gs_emp-pernr, gs_emp-gender )
*  WHERE pernr = '20220001'.
*
*WRITE : '사원명' , gs_emp-pernr.
*NEW-LINE.
*WRITE : 'EMANE : ' , gs_emp-ename.
*NEW-LINE.
*WRITE : '부서코드: ' , gs_emp-depid.
*WRITE : /'성별: ', gs_emp-gender.


*"loop문
*SELECT *
*  FROM ztsa2001
*  INTO CORRESPONDING FIELDS OF TABLE gt_emp.
*
*CLEAR gs_emp.
*LOOP AT gt_emp INTO gs_emp.
*  "gs_emp 를 바꾸는 로직
*  CASE gs_emp-gender.
*    WHEN '1'.
*      gs_emp-gender_t = '남성'.
*    WHEN '2'.
*      gs_emp-gender_t = '여성'.
*  ENDCASE.
*
*select single phone
*  from ztsa2002
*  into CORRESPONDING FIELDS OF gs_emp
*  where depid = gs_emp-depid.
*
*  MODIFY gt_emp FROM gs_emp.
*  CLEAR gs_emp.
*ENDLOOP.

"readtable
SELECT *
  FROM ztsa2001
  INTO CORRESPONDING FIELDS OF TABLE gt_emp.

SELECT *
  FROM ztsa2002
  INTO CORRESPONDING FIELDS OF TABLE gt_dep
  WHERE depid = 'D005' .

CLEAR gs_emp.
LOOP AT gt_emp INTO gs_emp.
"gs_emp
  read table gt_dep into gs_dep
  with key depid = gs_emp-depid.

  gs_emp-phone = gs_dep-phone.

    MODIFY gt_emp FROM gs_emp.
  CLEAR: gs_emp, gs_dep.
ENDLOOP.

cl_demo_output=>display_data( gt_emp ).
