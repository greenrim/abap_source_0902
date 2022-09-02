*&---------------------------------------------------------------------*
*& Include          YCL120_002_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form refresh_grid_0100
*&---------------------------------------------------------------------*
FORM refresh_grid_0100 .
  CHECK gr_alv IS BOUND.


  DATA ls_stable TYPE lvc_s_stbl.
  ls_stable-row = abap_off.
  ls_stable-col = abap_on.

  CALL METHOD gr_alv->refresh_table_display
    EXPORTING
      is_stable      = ls_stable
      i_soft_refresh = space    "SPACE : 설정된 필터, 정렬 정보를 초기화
      "'X'   : 설정된 필터나 정렬을 유지한다
    EXCEPTIONS
      finished       = 1
      OTHERS         = 2.

*  IF gr_alv IS BOUND.
*    "~~
*  ELSE.
*    EXIT. "현재 구간을 종료
*  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_object_0100
*&---------------------------------------------------------------------*
FORM create_object_0100 .

  gr_con = NEW cl_gui_custom_container(
    container_name = 'MY_CONTAINER'
    ).

  CREATE OBJECT gr_alv
    EXPORTING
      i_parent          = gr_con
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
FORM select_data .

  REFRESH  gt_scarr.
  RANGES : lr_carrid   FOR scarr-carrid,
           lr_carrname FOR scarr-carrname.

  IF scarr-carrid   IS INITIAL AND
     scarr-carrname IS INITIAL.
    "ID와 이름이 둘다 공란인 경우

  ELSEIF scarr-carrid IS INITIAL.
    "이름은 공란이 아닌 경우
    lr_carrname-sign   = 'I'.                 "I : INCLUDE / E : EXCLUDE
    lr_carrname-option = 'EQ'.                "EQ 같음
    lr_carrname-low    = scarr-carrname.
    "이거와 동일한 라인만 가져오겠다

    APPEND lr_carrname.
    CLEAR  lr_carrname.
  ELSEIF scarr-carrname IS INITIAL.
    "ID가 공란이 아닌 경우
    lr_carrid-sign    = 'I'.
    lr_carrid-option  = 'EQ'.
    lr_carrid-low     = scarr-carrid.
    APPEND lr_carrid.
    CLEAR  lr_carrname.

  ELSE.
    "ID와 이름이 둘다 공란이 아닌 경우
    lr_carrname-sign   = 'I'.
    lr_carrname-option = 'EQ'.
    lr_carrname-low    = scarr-carrname.
    APPEND lr_carrname.
    CLEAR  lr_carrname.

    lr_carrid-sign    = 'I'.
    lr_carrid-option  = 'EQ'.
    lr_carrid-low     = scarr-carrid.
    APPEND lr_carrid.
    CLEAR  lr_carrname.

  ENDIF.

  SELECT *
    FROM scarr
    INTO TABLE @gt_scarr
   WHERE carrid   IN @lr_carrid
    AND  carrname IN @lr_carrname.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_layout_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_alv_layout_0100 .

  CLEAR gs_layout.

  gs_layout-zebra      = abap_on.
  gs_layout-sel_mode    = 'D'.
  gs_layout-cwidth_opt = abap_on.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_fieldcat_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_alv_fieldcat_0100 .

  REFRESH gt_fcat.
  DATA lt_fieldcat TYPE kkblo_t_fieldcat.

  CALL FUNCTION 'K_KKB_FIELDCAT_MERGE'
    EXPORTING
      i_callback_program     = sy-repid         " Internal table declaration program
*     i_tabname              =                  " Name of table to be displayed
      i_strucname            = 'SCARR'
      i_inclname             = sy-repid         "이거 안 적어도 되긴한데 하지만 안전하게 적자
      i_bypassing_buffer     = abap_on          " Ignore buffer while reading
      i_buffer_active        = abap_off
    CHANGING
      ct_fieldcat            = lt_fieldcat      " Field Catalog with Field Descriptions
    EXCEPTIONS
      inconsistent_interface = 1
      OTHERS                 = 2.

  IF lt_fieldcat[] IS INITIAL.                  "못 가져오는 경우도 많아서 꼭 체크
    MESSAGE 'ALV 필드 카탈로그 구성이 실패하였습니다.' TYPE 'E'.
  ELSE.
    CALL FUNCTION 'LVC_TRANSFER_FROM_KKBLO'
      EXPORTING
        it_fieldcat_kkblo = lt_fieldcat
      IMPORTING
        et_fieldcat_lvc   = gt_fcat
      EXCEPTIONS
        it_data_missing   = 1
        OTHERS            = 2.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_alv_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv_0100 .

  CALL METHOD gr_alv->set_table_for_first_display
    EXPORTING
      is_layout                   = gs_layout
    CHANGING
      it_outtab                   = gt_scarr[]
      it_fieldcatalog             = gt_fcat[]
  EXCEPTIONS
    invalid_parameter_combination = 1
    program_error                 = 2
    too_many_lines                = 3
    OTHERS                        = 4.


ENDFORM.
