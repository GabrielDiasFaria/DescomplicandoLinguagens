*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_11
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_DLA7_11.

" Global -> Acessado por qualquer local do código
" Local  -> Acessado apenas pelo contexto local

DATA: gv_numero TYPE i.

FORM exibir.

  DATA: lv_numero TYPE i.

  WRITE: / 'Exibindo o GV: ', gv_numero.
  WRITE: / 'Exibindo o LV: ', lv_numero.

ENDFORM.

INITIALIZATION.
  gv_numero = 2.

  PERFORM exibir.
  WRITE: / gv_numero.
*  WRITE: / lv_numero.
