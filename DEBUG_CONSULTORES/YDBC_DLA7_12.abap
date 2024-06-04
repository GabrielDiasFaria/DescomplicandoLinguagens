*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_DLA7_12.

* Variáveis
DATA: lv_nome TYPE string.
lv_nome = 'Gabriel'.

DATA(lv_nome_inline) = 'Gabriel'.

" Estruturas
TYPES: BEGIN OF ty_cliente,
        nome  TYPE string,
        email TYPE string,
       END OF ty_cliente,
       tt_cliente TYPE TABLE OF ty_cliente WITH DEFAULT KEY.

DATA: ls_cliente TYPE ty_cliente.
ls_cliente-nome  = 'Gabriel'.
ls_cliente-email = 'gabrieldiasfaria@gmail.com'.

DATA(ls_cliente_inline) = VALUE ty_cliente( nome = 'Gabriel'
                                            email = 'gabrieldiasfaria@gmail.com' ).

" Tabelas
DATA: lt_cli TYPE TABLE OF ty_cliente,
      ls_cli TYPE ty_cliente.

ls_cli-nome  = 'Gabriel'.
ls_cli-email = 'gabrieldiasfaria@gmail.com'.
APPEND ls_cli TO lt_cli.

ls_cli-nome  = 'Alex'.
ls_cli-email = 'alex@gmail.com'.
APPEND ls_cli TO lt_cli.

" Forma 1
DATA(lt_cli_inline) = VALUE tt_cliente(
  ( nome = 'Gabriel' email = 'gabrieldiasfaria@gmail.com' )
  ( nome = 'Alex'    email = 'alex@gmail.com' )
).

" Forma 2
APPEND VALUE ty_cliente( nome = 'Brito'
                         email = 'brito@gmail.com' ) TO lt_cli_inline.
