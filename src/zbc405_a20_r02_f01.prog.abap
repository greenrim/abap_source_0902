*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_R02_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form set_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .

  gs_layout_1-zebra = 'X'.
  gs_layout_1-grid_title = 'TABLE_SFLIGHT'.
  gs_layout_1-sel_mode = 'A'.
*  gs_layout_1-cwidth_opt = 'X'.
  gs_layout_1-excp_fname = 'LIGHT'.
  gs_layout_1-excp_led = 'X'.
  gs_layout_1-info_fname = 'ROW_COLOR'.
  gs_layout_1-ctab_fname = 'GT_COLOR'.

  gs_layout_2-no_toolbar = 'X'.
  gs_layout_2-sel_mode = 'D'.

  APPEND cl_gui_alv_grid=>mc_fc_detail TO gt_excluded_functions.

ENDFORM.
