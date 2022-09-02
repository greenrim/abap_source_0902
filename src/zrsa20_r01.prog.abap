*&---------------------------------------------------------------------*
*& Report ZRSA20_R01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa20_r01.

DATA: gt_info TYPE TABLE OF spfli.
PARAMETERS: pa_city TYPE spfli-cityfrom,
            pa_air  TYPE spfli-airpfrom.

SELECT *
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_info
  WHERE cityfrom = pa_city AND airpfrom = pa_air.
cl_demo_output=>display_data( gt_info ).
