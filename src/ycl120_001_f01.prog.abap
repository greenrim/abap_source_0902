*&---------------------------------------------------------------------*
*& Include          YCL120_001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM select_data .

  REFRESH gt_scarr. "Internal Table 초기화

*  SELECT *
**  SELECT CASE carrid WHEN carrid = 'AA' THEN '빠밤'
**         ELSE carrid END
*      FROM scarr
*        INTO TABLE @gt_scarr
*       WHERE carrid  IN @s_carrid
*        AND carrname IN @s_carrnm.

  SELECT *
    FROM scarr
   WHERE carrid   IN @s_carrid
     AND carrname IN @s_carrnm
    INTO TABLE @gt_scarr.

  SORT gt_scarr BY carrid.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_OBJECT_0100
*&---------------------------------------------------------------------*
FORM create_object_0100 .

  CREATE OBJECT gr_con
    EXPORTING
      repid                       = sy-repid         " Report to Which This Docking Control is Linked
      dynnr                       = sy-dynnr         " Screen to Which This Docking Control is Linked
*     side                        = dock_at_left     " Side to Which Control is Docked
      extension                   = 3000             " Control Extension
    EXCEPTIONS
      cntl_error                  = 1                " Invalid Parent Control
      cntl_system_error           = 2                " System Error
      create_error                = 3                " Create Error
      lifetime_error              = 4                " Lifetime Error
      lifetime_dynpro_dynpro_link = 5                " LIFETIME_DYNPRO_DYNPRO_LINK
      OTHERS                      = 6.

  CREATE OBJECT gr_split
    EXPORTING
      parent            = gr_con             " Parent Container
      rows              = 2                  " Number of Rows to be displayed
      columns           = 1                  " Number of Columns to be Displayed
    EXCEPTIONS
      cntl_error        = 1                  " See Superclass
      cntl_system_error = 2                  " See Superclass
      OTHERS            = 3.


  gr_con_top = gr_split->get_container(
    EXPORTING
      row       = 1               " Row
      column    = 1               " Column
*  receiving
*    container = gr_con_top       " Container
  ).

  gr_con_alv = gr_split->get_container( row = 2 column = 1 ).



  "create alv 방식이 훨씬 친절함
  CREATE OBJECT gr_alv
    EXPORTING
      i_parent          = gr_con_alv          " Parent Container
    EXCEPTIONS
      error_cntl_create = 1                " Error when creating the control
      error_cntl_init   = 2                " Error While Initializing Control
      error_cntl_link   = 3                " Error While Linking Control
      error_dp_create   = 4                " Error While Creating DataProvider Control
      OTHERS            = 5.

*  gr_alv = NEW cl_gui_alv_grid( i_parent = gr_con_alv ).
*  우측 주석이 없고, class를 기억해야하는 단점이 있음
*  gr_alv = new #(  i_parent  = gr_con_alv ).
*  #은 왼쪽 참조 변수의 타입을 참고해서 만든다는 의미

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_layout_0100
*&---------------------------------------------------------------------*
FORM set_alv_layout_0100 .

  CLEAR gs_layout.
  gs_layout-zebra      = abap_on. "X
  gs_layout-sel_mode   = 'D'.     "A 행열 / B단일행 / C복수행 / D셀단위
  gs_layout-cwidth_opt = abap_on.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_fieldcat_0100
*&---------------------------------------------------------------------*
FORM set_alv_fieldcat_0100 .

  DATA lt_fieldcat TYPE kkblo_t_fieldcat.

  CALL FUNCTION 'KK_KKB_FIELDCAT_MERGE'
    EXPORTING
      i_callback_program     = sy-repid          " Internal table declaration program
*     i_tabname              = 'GS_SCARR'
*    "ITAB이름이 아닌 구조체 이름 기재          " Name of table to be displayed
      i_strucname            = 'SCARR'
      "TABLE에서 SCARR를 찾고 FIELDCAT를 자동으로 만들어줌
      i_inclname             = sy-repid
      i_bypassing_buffer     = abap_on                " Ignore buffer while reading
      "메모리에 저장된 값을 가져올거야 말거야?
      i_buffer_active        = abap_off " 버퍼 비활성화
      "FCAT을 메모리에 저장할거야 말거야
    CHANGING
      ct_fieldcat            = lt_fieldcat        " Field Catalog with Field Descriptions
    EXCEPTIONS
      inconsistent_interface = 1
      OTHERS                 = 2.

  IF lt_fieldcat[] IS INITIAL.
    MESSAGE '필드 카탈로그 구성 중 오류가 발생했습니다.' TYPE 'E'.
  ELSE.
    CALL FUNCTION 'LLVC_TRANSFER_FROM_KKBLO'
      EXPORTING
        it_fieldcat_kkblo = lt_fieldcat
      IMPORTING
        et_fieldcat_lvc   = gt_fieldcat
      EXCEPTIONS
        it_data_missing   = 1
        OTHERS            = 2.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_alv_0100
*&---------------------------------------------------------------------*
FORM display_alv_0100 .

  CALL METHOD gr_alv->set_table_for_first_display
    EXPORTING
*     is_variant                    =                  " Layout
*     i_save                        =                  " Save Layout
*     i_default                     = 'X'              " Default Display Variant
      is_layout                     = gs_layout         " Layout
    CHANGING
      it_outtab                     = gt_scarr[]        " Output Table
      it_fieldcatalog               = gt_fieldcat[]     " Field Catalog
    EXCEPTIONS
      invalid_parameter_combination = 1                " Wrong Parameter
      program_error                 = 2                " Program Errors
      too_many_lines                = 3                " Too many Rows in Ready for Input Grid
      OTHERS                        = 4.
ENDFORM.
