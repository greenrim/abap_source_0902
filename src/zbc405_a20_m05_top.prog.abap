*&---------------------------------------------------------------------*
*& Include ZBC405_A20_M05_TOP                       - Report ZBC405_A20_M05
*&---------------------------------------------------------------------*
REPORT zbc405_a20_m05.

**"1 사원설명
*TYPES : BEGIN OF ts_info,
*          pernr TYPE ztsa2001-pernr,
*          ename TYPE ztsa2001-ename,
*          depid TYPE ztsa2001-depid,
*          phone TYPE ztsa2002-phone,
*          dtext TYPE ztsa2002_t-dtext,
*        END OF ts_info.
*
*DATA : gs_info TYPE ts_info,
*       gt_info LIKE TABLE OF gs_info.

TYPES : BEGIN OF ts_info.
          INCLUDE TYPE ztsa2001.
TYPES :   gendert TYPE c LENGTH 10,
        END OF ts_info.

DATA : gs_info TYPE ts_info,
       gt_info LIKE TABLE OF gs_info.



*"2 부서 설명
*TYPES : BEGIN OF ts_emp,
**INCLUDE TYPE ztsa2002.
*          depid TYPE ztsa2002-depid,
*          phone TYPE ztsa2002-phone,
*          dtext TYPE ztsa2002_t-dtext,
*        END OF ts_emp.
*
*DATA : gs_emp TYPE ts_emp,
*       gt_emp LIKE TABLE OF gs_emp.
*
*"SELECTION SCREEN
**PARAMETERS : pa_per TYPE ztsa2001-pernr.
*
*TABLES ztsa2001.
*SELECT-OPTIONS so_per FOR ztsa2001-pernr.
