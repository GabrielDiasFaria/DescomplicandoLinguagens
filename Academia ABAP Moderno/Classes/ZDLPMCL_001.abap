class ZDLPMCL_001 definition
  public
  abstract
  create public .

public section.

  data AV_TABLE type STRING .

  methods CONSTRUCTOR
    importing
      !IV_TABLE type STRING .
  methods READ .
  methods CREATE
    changing
      !IS_DATA type ANY
    returning
      value(RS_RESULT) type BAPIRET2
    raising
      ZDLPMCL_003 .
  methods UPDATE
    changing
      !IS_DATA type ANY
    returning
      value(RS_RESULT) type BAPIRET2
    raising
      ZDLPMCL_003 .
  methods DELETE
    importing
      !IS_DATA type ANY
    returning
      value(RS_RESULT) type BAPIRET2
    raising
      ZDLPMCL_003 .
  methods VALIDATE
    importing
      !IS_DATA type ANY
      !IV_IS_DELETE type XFELD optional
    raising
      ZDLPMCL_003 .
protected section.
private section.
ENDCLASS.



CLASS ZDLPMCL_001 IMPLEMENTATION.


  method CONSTRUCTOR.

    me->av_table = iv_table.

  endmethod.


  METHOD create.

    GET TIME STAMP FIELD DATA(lv_timestamp).

    " Preenchendo Criado Por
    ASSIGN COMPONENT `CRIADO_POR` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_criado_por>).
    IF <fs_criado_por> IS ASSIGNED.
      <fs_criado_por> = sy-uname.
    ENDIF.

    " Preenchendo Criado Em
    ASSIGN COMPONENT `CRIADO_EM` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_criado_em>).
    IF <fs_criado_em> IS ASSIGNED.
      <fs_criado_em>  = lv_timestamp.
    ENDIF.

    " Preenchendo ID
    ASSIGN COMPONENT `ID` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_id>).
    IF <fs_id> IS ASSIGNED.
      <fs_id> = cl_system_uuid=>create_uuid_c32_static( ).
    ENDIF.

    TRY .
      me->validate( is_data ).
    CATCH zdlpmcl_003 INTO DATA(exc).
      " Erro disparado!
      DATA(lv_msg) = exc->get_text( ).

      rs_result = VALUE bapiret2(
        type    = 'E'
        message = lv_msg
      ).

      RETURN.
    ENDTRY.

*   Criar o Registro!
    MODIFY (av_table) FROM is_data.

    rs_result = VALUE bapiret2(
      type        = 'S'
      message     = 'Criado com sucesso!'
      message_v1  = <fs_id>
    ).

  ENDMETHOD.


  METHOD delete.

*   Buscando Referência ID
    ASSIGN COMPONENT `ID`  OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_delete_id>).

    TRY .
      me->validate( EXPORTING is_data = is_data iv_is_delete = abap_true ).
    CATCH zdlpmcl_003 INTO DATA(exc).
      " Erro disparado!
      DATA(lv_msg) = exc->get_text( ).

      rs_result = VALUE bapiret2(
        type    = 'E'
        message = lv_msg
      ).

      RETURN.
    ENDTRY.

*   Delete o Registro!
    DELETE (me->av_table) FROM is_data.

    rs_result = VALUE bapiret2(
      type        = 'S'
      message     = 'Modificado com sucesso!'
      message_v1  = <fs_delete_id>
    ).

  ENDMETHOD.


  method READ.
  endmethod.


  method UPDATE.

    GET TIME STAMP FIELD DATA(lv_timestamp).

    " Preenchendo Modificado Por
    ASSIGN COMPONENT `MODIFICADO_POR` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_modificado_por>).
    IF <fs_modificado_por> IS ASSIGNED.
      <fs_modificado_por> = sy-uname.
    ENDIF.

    " Preenchendo Modificado Em
    ASSIGN COMPONENT `MODIFICADO_EM`  OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_modificado_em>).
    IF <fs_modificado_em> IS ASSIGNED.
      <fs_modificado_em>  = lv_timestamp.
    ENDIF.

*   Buscando Referência ID
    ASSIGN COMPONENT `ID`  OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_modificado_id>).

    TRY .
      me->validate( is_data ).
    CATCH zdlpmcl_003 INTO DATA(exc).
      " Erro disparado!
      DATA(lv_msg) = exc->get_text( ).

      rs_result = VALUE bapiret2(
        type    = 'E'
        message = lv_msg
      ).

      RETURN.
    ENDTRY.

*   Modificar o Registro!
    MODIFY (av_table) FROM is_data.

    rs_result = VALUE bapiret2(
      type        = 'S'
      message     = 'Modificado com sucesso!'
      message_v1  = <fs_modificado_id>
    ).

  endmethod.


  METHOD validate.

  ENDMETHOD.
ENDCLASS.