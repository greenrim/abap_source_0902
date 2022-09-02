class ZCL_IM_BC425IMA20 definition
  public
  final
  create public .

public section.

  interfaces IF_EX_BADI_BOOK20 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_BC425IMA20 IMPLEMENTATION.


  method IF_EX_BADI_BOOK20~CHANGE_VLINE.

    c_pos = c_pos + 38.

  endmethod.


  method IF_EX_BADI_BOOK20~OUTPUT.
    DATA : gv_name type ztscustom_a20-name.
*           gv_orderdate type z

    select single name
      from ztscustom_a20
      into gv_name
      where id = i_booking-CUSTOMID.


     write : gv_name, i_booking-order_date.


  endmethod.
ENDCLASS.
