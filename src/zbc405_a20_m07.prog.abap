*&---------------------------------------------------------------------*
*& Report ZBC405_A20_M07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a20_m07.

*DATA: BEGIN OF gs_data,
*        carrid    TYPE scarr-carrid,
*        carrname  TYPE scarr-carrname,
*        connid    TYPE sflight-connid,
*        fldate    TYPE sflight-fldate,
*        planetype TYPE sflight-planetype,
*        max       TYPE sflight-seatsmax,
*        seatsocc  TYPE sflight-seatsocc,
*      END OF gs_data,
*
*      gt_data LIKE TABLE OF gs_data.
*
*
*SELECT carrid connid fldate planetype seatsmax AS max seatsocc
*  FROM sflight
*  INTO CORRESPONDING FIELDS OF TABLE gt_data
*  WHERE fldate BETWEEN '20210101' AND '20210228'.
**  AND seatsocc BETWEEN 300 AND 320.
**  AND seatsocc >= 300
**  AND seatsocc <= 320.
*
*cl_demo_output=>display_data( gt_data ).

*DATA: BEGIN OF gs_data,
*        matnr TYPE mara-matnr,
*        aenam TYPE  mara-aenam,
*        mtart TYPE mara-mtart,
*        matkl TYPE  mara-matkl,
*        meins TYPE mara-meins,
*        brgew TYPE mara-brgew,
*        ntgew TYPE mara-ntgew,
*        gewei TYPE mara-gewei,
*      END OF gs_data,
*
*      gt_data LIKE TABLE OF gs_data.
*
*
*SELECT matnr aenam mtart matkl meins brgew ntgew gewei
*  FROM mara
*  INTO CORRESPONDING FIELDS OF TABLE gt_data
*  WHERE meins = 'ST'
*  AND laeda < '20220101'.
*
*LOOP AT gt_data INTO gs_data.
*  IF gs_data-brgew < '0.5'.
*    gs_data-matkl = '02'.
*    MODIFY gt_data FROM gs_data TRANSPORTING matkl.
*  ENDIF.
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_data ).

*DATA: BEGIN OF gs_data,
*        matnr      TYPE mara-matnr,
*        mtart      TYPE mara-mtart,
*        mtbez      TYPE t134t-mtbez,
*        matkl      TYPE mara-matkl,
*        wgbez      TYPE t023t-wgbez,
*        meins      TYPE mara-meins,
*        mtpos_mara TYPE mara-mtpos_mara,
*        bezei      TYPE tptmt-bezei,
*      END OF gs_data,
*
*      gt_data LIKE TABLE OF gs_data,
*
*      BEGIN OF gs_text1,
*        matkl TYPE t023t-matkl,
*        wgbez TYPE  t023t-wgbez,
*      END OF gs_text1,
*
*      gT_text1 LIKE TABLE OF gs_text1,
*
*      BEGIN OF gs_text2,
*        mtart TYPE  t134t-mtart,
*        mtbez TYPE  t134t-mtbez,
*      END OF gs_text2,
*
*      gt_text2 LIKE TABLE OF gs_text2.
*
**SELECT matnr  mtart matkl meins
**  FROM mara
**  INTO CORRESPONDING FIELDS OF TABLE gt_data
**  WHERE meins = 'ST'
**  AND laeda < '20220101'.
**
**SELECT matkl wgbez
**  FROM t023t
**  INTO CORRESPONDING FIELDS OF TABLE gt_matkl
**  WHERE spras = sy-langu.
**
**LOOP AT gt_data INTO gs_data.
**  READ TABLE gt_matkl INTO gs_matkl WITH KEY matkl = gs_data-matkl.
**
**  gs_data-wgbez = gs_matkl-wgbez.
**  MODIFY gt_data FROM gs_data TRANSPORTING wgbez.
**ENDLOOP.
*
**SELECT a~matnr  a~mtart a~matkl a~meins a~mtpos_mara b~wgbez
**  FROM mara AS a INNER JOIN t023t AS b
**  ON a~matkl = b~matkl
**  INTO CORRESPONDING FIELDS OF TABLE gt_data
**  WHERE meins = 'ST'
**  AND laeda < '20220101'
**  AND b~spras = sy-langu.
*
*SELECT matnr  mtart matkl mtpos_mara
*  FROM mara
*  INTO CORRESPONDING FIELDS OF TABLE gt_data
*  WHERE meins = 'ST'
*  AND laeda < '20220101'.
*
*SELECT matkl wgbez
*  FROM t023t
*  INTO CORRESPONDING FIELDS OF TABLE gt_text1
*  WHERE spras = sy-langu.
*
*SELECT mtart mtbez
*  FROM t134t
*  INTO CORRESPONDING FIELDS OF TABLE gt_text2
*  WHERE spras = sy-langu.
*
*LOOP AT gt_Data INTO gs_Data.
*
*  READ TABLE gt_text1 INTO gs_text1 WITH KEY matkl = gs_data-matkl.
*  gs_data-wgbez = gs_text1-wgbez.
*  MODIFY gt_data FROM gs_data TRANSPORTING wgbez.
*
*  READ TABLE gt_text2 INTO gs_text2 WITH KEY mtart = gs_data-mtart.
*  gs_data-mtbez = gs_text2-mtbez.
*  MODIFY gt_data FROM gs_data TRANSPORTING mtbez.
*
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_data ).

TABLES bkpf.
*PARAMETERS : "pa_bukr TYPE bkpf-bukrs OBLIGATORY DEFAULT '1010',

SELECT-OPTIONS : so_beln FOR bkpf-belnr,
                 so_blart FOR bkpf-blart,
                 pa_bukr FOR bkpf-bukrs,
                 pa_gjah FOR bkpf-gjahr .

DATA : BEGIN OF gs_data,
         belnr TYPE bseg-belnr,
         buzei TYPE bseg-buzei,
         blart TYPE bkpf-blart,
         budat TYPE bkpf-budat,
         shkzg TYPE bseg-shkzg,
         dmbtr TYPE bseg-dmbtr,
         waers TYPE bkpf-waers,
         bukrs TYPE bkpf-bukrs,
         hkont TYPE bseg-hkont,
         gjahr TYPE bkpf-gjahr,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data.
*SELECT bukrs BELNR GJAHR blart budat waers
*  FROM bkpf
*    INTO CORRESPONDING FIELDS OF TABLE gt_Data
*  WHERE bukrs in pa_BUKR
*  AND gjahr in pa_GJAh
*  AND belnr IN so_beln
*  AND blart IN so_blart.

SELECT b~belnr b~buzei a~blart a~budat b~shkzg b~dmbtr a~waers b~hkont a~bukrs a~gjahr
   FROM  bkpf AS a INNER JOIN bseg AS b
     ON a~bukrs = b~bukrs AND
        a~belnr = b~belnr AND
        a~gjahr = b~gjahr
   INTO CORRESPONDING FIELDS OF TABLE gt_data
   WHERE : a~bukrs IN pa_bukr AND
           a~gjahr IN pa_gjah AND
           a~belnr IN so_beln AND
           a~blart IN so_blart.


cl_demo_output=>display_data( gt_data ).
