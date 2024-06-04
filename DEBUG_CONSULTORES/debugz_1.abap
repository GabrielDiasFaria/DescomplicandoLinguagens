
" Programa: SAPBC_DATA_GENERATOR

TABLES: sflight.

SELECT-OPTIONS: so_car FOR sflight-carrid,
                so_con FOR sflight-connid.

CLASS lcl_main DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_alv,
             color TYPE  lvc_t_scol.
             INCLUDE TYPE sflight.
    TYPES: END OF ty_alv.
    DATA lt_sflight TYPE TABLE OF ty_alv.

    CLASS-METHODS create
      RETURNING
        VALUE(r_result) TYPE REF TO lcl_main.

    METHODS run.
    METHODS get_data.
    METHODS validate_data.
    METHODS fill_colors.
    METHODS display_alv.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD create.
    CREATE OBJECT r_result.
  ENDMETHOD.

  METHOD run.
    get_data( ).
    validate_data( ).
    fill_colors( ).
    display_alv( ).
  ENDMETHOD.

  METHOD get_data.

    SELECT *
      FROM sflight
      INTO CORRESPONDING FIELDS OF TABLE @lt_sflight.

  ENDMETHOD.

  METHOD validate_data.

    " Erro - Quando não acha dados
    IF lt_sflight[] IS INITIAL.
      MESSAGE 'Não foram encontrados dados!' TYPE 'E'.
    ENDIF.

    " Erro - Quando não tem pelo menos um AA
    DATA(ls_sflight) = VALUE ty_alv( lt_sflight[ carrid = 'AA' ] OPTIONAL ).
    IF ls_sflight IS INITIAL.
      MESSAGE 'Não foram encontrados dados AA!' TYPE 'E'.
    ENDIF.

  ENDMETHOD.

  METHOD fill_colors.

    DATA(ls_color_warning) = VALUE lvc_s_colo( col = 6 int = 0 inv = 0 ).
    DATA(ls_color_red)     = VALUE lvc_s_colo( col = 1 int = 0 inv = 0 ).
    DATA(ls_color_green)   = VALUE lvc_s_colo( col = 5 int = 0 inv = 0 ).

    LOOP AT lt_sflight ASSIGNING FIELD-SYMBOL(<fs_sflight>).
      DATA(lv_percent_occuped) = ( <fs_sflight>-seatsocc * 100 ) / <fs_sflight>-seatsmax.

      IF lv_percent_occuped < 50.
        APPEND VALUE lvc_s_scol( fname = '' color = ls_color_green nokeycol = '' ) TO <fs_sflight>-color.
      ELSEIF lv_percent_occuped >= 50 AND lv_percent_occuped < 80.
        APPEND VALUE lvc_s_scol( fname = '' color = ls_color_warning nokeycol = '' ) TO <fs_sflight>-color.
      ELSEIF lv_percent_occuped >= 80.
        APPEND VALUE lvc_s_scol( fname = '' color = ls_color_green nokeycol = '' ) TO <fs_sflight>-color.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD display_alv.

    cl_salv_table=>factory(
      IMPORTING r_salv_table = DATA(lo_salv_alv)
      CHANGING  t_table      = lt_sflight
    ).

    lo_salv_alv->get_columns( )->set_color_column( 'COLOR' ).

    lo_salv_alv->display( ).

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl_main=>create( )->run( ).
