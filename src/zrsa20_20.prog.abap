*&---------------------------------------------------------------------*
*& Report ZRSA2020
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_20.

DATA : BEGIN OF gs_info,
         carrid    TYPE spfli-carrid,
         carrname  TYPE scarr-carrname,
         connid    TYPE spfli-connid,
         countryfr TYPE spfli-countryfr,
         countryto TYPE spfli-countryto,
         atype     TYPE c LENGTH 10,
       END OF gs_info,
       gt_info LIKE TABLE OF gs_info.

PERFORM internal_Table USING 'AA' '0017'.
PERFORM internal_Table USING 'AA' '0064'.
PERFORM internal_Table USING 'AZ' '0555'.

*SELECT SINGLE carrid connid countryfr countryto
*  FROM spfli
*  INTO CORRESPONDING FIELDS OF gs_info
*WHERE carrid = 'AA' AND connid = '0017'.
*
*
*APPEND gs_info TO gt_info.
*
*SELECT SINGLE carrid connid countryfr countryto
*  FROM spfli
*  INTO CORRESPONDING FIELDS OF gs_info
*WHERE carrid = 'AA' AND connid = '0064'.
*APPEND gs_info TO gt_info.
*
*SELECT SINGLE carrid connid countryfr countryto
*  FROM spfli
*  INTO CORRESPONDING FIELDS OF gs_info
*  WHERE carrid = 'AZ'.
*
*APPEND gs_info TO gt_info.

LOOP AT gt_info INTO gs_info.
  CASE gs_info-countryfr.
    WHEN gs_info-countryto.
      gs_info-atype = '국내선'.
    WHEN OTHERS.
      gs_info-atype = '해외선'.
  ENDCASE.
  MODIFY gt_info FROM gs_info.
  CLEAR gs_info.
ENDLOOP.

LOOP AT gt_info INTO gs_info.
  PERFORM add_carrname.

*  SELECT SINGLE carrname
*    FROM scarr
*    INTO CORRESPONDING FIELDS OF gs_info
*    WHERE carrid = gs_info-carrid.
*  MODIFY gt_info FROM gs_info.
*  CLEAR gs_info.

  MODIFY gt_info FROM gs_info.
  CLEAR gs_info.
ENDLOOP.

cl_demo_output=>display_data( gt_info ).
*&---------------------------------------------------------------------*
*& Form internal_Table
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM internal_Table USING VALUE(p_code)
                          VALUE(p_connid).
  SELECT SINGLE carrid connid countryfr countryto
    FROM spfli
    INTO CORRESPONDING FIELDS OF gs_info
    WHERE carrid = p_code AND connid = p_connid.

  APPEND gs_info TO gt_info.
  CLEAR gs_info.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form add_carrname
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM add_carrname.
  SELECT SINGLE carrname
    FROM scarr
    INTO CORRESPONDING FIELDS OF gs_info
    WHERE carrid = gs_info-carrid.
ENDFORM.
