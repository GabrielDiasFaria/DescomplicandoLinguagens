
TABLES: sflight.

SELECTION-SCREEN BEGIN OF BLOCK 100.
  SELECT-OPTIONS: s_carr FOR sflight-carrid,
                  s_conn FOR sflight-connid.

  PARAMETERS: c_test AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK 100.

TYPES: BEGIN OF ty_sflight,
         total_earn TYPE s_price.
         INCLUDE TYPE sflight.
TYPES: END OF ty_sflight.

DATA: gt_sflight TYPE TABLE OF ty_sflight.

INITIALIZATION.
  %_s_carr_%_app_%-text = 'Companhia Aerea'.
  %_s_conn_%_app_%-text = 'Conexão'.
  %_c_test_%_app_%-text = 'Calcular Total Lucro?'.


START-OF-SELECTION.
  PERFORM get_data.
  PERFORM validate_data.
  PERFORM change_data.
  PERFORM display_alv.

FORM get_data.

  CLEAR: gt_sflight[].
  REFRESH gt_sflight.

  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE @gt_sflight
    WHERE carrid IN @s_carr
      AND connid IN @s_conn.

ENDFORM.

FORM validate_data.

  LOOP AT gt_sflight INTO DATA(ls_sflight).
    IF ls_sflight-seatsocc < 300.
      DELETE gt_sflight INDEX sy-tabix.
    ENDIF.
  ENDLOOP.

ENDFORM.

FORM change_data.

  CHECK c_test IS NOT INITIAL.
  DATA lv_total_earn TYPE s_seatsocc.

  LOOP AT gt_sflight ASSIGNING FIELD-SYMBOL(<fs_sflight>).
    IF lv_total_earn IS INITIAL.
      lv_total_earn = <fs_sflight>-price * <fs_sflight>-seatsocc.
    ENDIF.
    <fs_sflight>-total_earn = lv_total_earn.
  ENDLOOP.

ENDFORM.

FORM display_alv.

  cl_salv_table=>factory(
      IMPORTING r_salv_table = DATA(lo_salv_alv)
      CHANGING  t_table      = gt_sflight
    ).

  lo_salv_alv->display( ).

ENDFORM.
