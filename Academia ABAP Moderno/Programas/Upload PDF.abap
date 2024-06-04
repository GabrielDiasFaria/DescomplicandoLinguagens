CLASS lcl_main DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.

    CLASS-DATA: lt_pdf_object       TYPE TABLE OF x255,
                lo_dock_container   TYPE REF TO cl_gui_docking_container,
                lo_html             TYPE REF TO cl_gui_html_viewer,
                lv_url              TYPE char255.

    CLASS-METHODS create
      RETURNING VALUE(r_result) TYPE REF TO lcl_main.

   CLASS-METHODS: run,
                  upload_pdf,
                  display_pdf,
                  pbo_display_pdf.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD create.
    CREATE OBJECT r_result.
  ENDMETHOD.

  METHOD run.

    upload_pdf( ).
    display_pdf( ).

  ENDMETHOD.

  METHOD upload_pdf.

    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename = 'C:\Users\diego\Downloads\Note 504692.pdf'
        filetype = 'BIN'
      TABLES
        data_tab  =  lt_pdf_object .

  ENDMETHOD.

  METHOD display_pdf.
    CALL SCREEN 100.
  ENDMETHOD.

   METHOD pbo_display_pdf.

     CREATE OBJECT lo_dock_container
        EXPORTING
          repid     = sy-repid
          dynnr     = sy-dynnr
          extension = 1000.

  CREATE OBJECT lo_html
    EXPORTING
      parent = lo_dock_container.

  lo_html->load_data(
    EXPORTING
      type                   = 'application'
      subtype                = 'pdf'
    IMPORTING
      assigned_url            =  lv_url
    CHANGING
      data_table              =  lt_pdf_object
  ).

lo_html->show_url( url =  lv_url in_place = 'X' ).

  ENDMETHOD.


ENDCLASS.


START-OF-SELECTION.

lcl_main=>create( )->run( ).

MODULE pbo_100 OUTPUT.

lcl_main=>pbo_display_pdf( ).

ENDMODULE.
