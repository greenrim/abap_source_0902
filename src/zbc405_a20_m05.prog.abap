*&---------------------------------------------------------------------*
*& Report ZBC405_A20_M05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a20_m05_top                      .    " Global Data

* INCLUDE ZBC405_A20_M05_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A20_M05_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A20_M05_F01                      .  " FORM-Routines

*"사번으로 특정 사원 조회
*SELECT SINGLE *
*  FROM ztsa2001
*  INTO gs_info
*  WHERE pernr = '20220001'.
*
*SELECT SINGLE pernr depid
*  FROM ztsa2001
*  INTO gs_info
*  WHERE pernr = '20220001'.
*
*SELECT SINGLE pernr depid
*  FROM ztsa2001
*  INTO ( gs_info-pernr, gs_info-depid )
*  WHERE pernr = '20220001'.
*
*SELECT SINGLE pernr depid
*  FROM ztsa2001
*  INTO CORRESPONDING FIELDS OF gs_info
*  WHERE pernr = '20220001'.
*
**SELECT SINGLE pernr depid as dep
**  FROM ztsa2001
**  INTO CORRESPONDING FIELDS OF gs_info "( gs_info-pernr, gs_info-depid )
**  WHERE pernr = pa_pernr.  "'20220001'.
*
**SELECT SINGLE pernr depid
**  FROM ztsa2001
**  INTO ( gs_info-pernr, gs_info-dep )
**  WHERE pernr = '20220001'.
*
*WRITE : '사원명:' , gs_info-pernr.
*NEW-LINE.
*WRITE : 'ename:', gs_info-ename.
*NEW-LINE.
*WRITE : '부서코드:', gs_info-dep.
*WRITE : / '부서명:', gs_info-dtext.

SELECT *
  FROM ztsa2001
  INTO CORRESPONDING FIELDS OF TABLE gt_INFO.

LOOP AT gt_info INTO gs_info.
  CASE gs_info-gender.
    WHEN '1'.
      gs_info-gendert = '여성'.
    WHEN '2'.
      gs_info-gendert = '남성'.
  ENDCASE.

  MODIFY gt_info FROM gs_info.

ENDLOOP.



*"특정 부서의 사원들 조회
*SELECT *
*  FROM ztsa2002
*  INTO CORRESPONDING FIELDS OF TABLE gt_emp.
*
*READ TABLE gt_emp INTO gs_emp WITH KEY depid = 'D001'.
*
*READ TABLE gt_emp INTO gs_emp INDEX 2.
*
*WRITE : '부서코드:' , gs_emp-depid.
*NEW-LINE.
*WRITE : '내선번호:', gs_emp-phone.
*NEW-LINE.
*WRITE : '부서명:', gs_emp-dtext.

*
*SELECT *
*  FROM ztsa2001
*  INTO CORRESPONDING FIELDS OF TABLE gt_info
*  WHERE pernr IN so_per.
*
**READ TABLE gt_info INTO gs_info WITH KEY depid = 'D002'.
*
cl_demo_output=>display_data( gt_info ).
