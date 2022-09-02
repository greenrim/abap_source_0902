*&---------------------------------------------------------------------*
*& Include          ZC1R200007_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form set_fcat_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat_layout .
  gs_layout-zebra       = 'X'.
  gs_layout-cwidth_opt  = 'X'.
  gs_layout-sel_mode    = 'D'.

  IF gt_fcat IS INITIAL.
    "KEY / FNAME / COLTEXT / RT / RF / RC / RM
    PERFORM set_fcat USING :
      'X' 'MATNR' '' 'MARA' 'MATNR' '' '',
      ''  'MTART' '' 'MARA' 'MTART' '' '',
      ''  'MATKL' '' 'MARA' 'MATKL' '' '',
      ''  'MEINS' '' 'MARA' 'MEINS' '' '',
      ''  'TRAGR' '' 'MARA' 'TRAGR' '' '',
      ''  'PSTAT' '' 'MARC' 'PSTAT' '' '',
      ''  'DISMM' '' 'MARC' 'DISMM' '' '',
      ''  'EKGRP' '' 'MARC' 'EKGRP' '' ''.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING p_key p_fname p_ctext p_ref_t p_ref_f p_curr p_quan.

  gt_fcat = VALUE #( BASE gt_fcat
                     (
                     key       = p_key
                     fieldname = p_fname
                     coltext   = p_ctext
                     ref_table = p_ref_t
                     ref_field = p_ref_f
*                     currency  = p_curr
*                     quantity  = p_quan
                     )
                    ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .

  SELECT a~matnr  a~mtart  a~matkl  a~meins  a~tragr
         b~pstat  b~dismm  b~ekgrp
    FROM mara AS a INNER JOIN marc AS b
    ON   a~matnr = b~matnr
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    WHERE b~werks  =  pa_werk
    AND   a~matnr  IN so_matn
    AND   a~mtart  IN so_mtar
    AND   b~ekgrp  IN so_ekgr.

ENDFORM.
