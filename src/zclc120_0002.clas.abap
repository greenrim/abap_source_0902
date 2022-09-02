class ZCLC120_0002 definition
  public
  final
  create public .

public section.

  methods GET_MATERIAL_INFO
    importing
      !PI_MATNR type MARA-MATNR
      !PI_SPRAS type MAKT-SPRAS
    exporting
      !PE_MAKTX type MAKT-MAKTX
      !PE_CODE type CHAR1
      !PE_MSG type CHAR100 .
protected section.
private section.
ENDCLASS.



CLASS ZCLC120_0002 IMPLEMENTATION.


  METHOD get_material_info.

    IF pi_matnr IS INITIAL.
      pe_code = 'E'.
      pe_msg = TEXT-e01.
      EXIT.
    ENDIF.

    SELECT SINGLE maktx
      FROM makt
      INTO pe_maktx
     WHERE matnr = pi_matnr
       and spras = pi_spras.

    IF sy-subrc NE 0.
      pe_code = 'E'.
      pe_msg = TEXT-e02.
      EXIT.
    ELSE.
      pe_code = 'S'.
    ENDIF.


  ENDMETHOD.
ENDCLASS.
