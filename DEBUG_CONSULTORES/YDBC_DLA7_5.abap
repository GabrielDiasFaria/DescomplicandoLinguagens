*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydbc_dla7_5.


" YDBCT_DLA7_1

TYPES: tt_mes TYPE TABLE OF ydbct_dla7_1 WITH DEFAULT KEY.

" Forma Tradicional de Inserir na Tabela
DATA: ls_mes TYPE ydbct_dla7_1.

ls_mes-mes = 1.
ls_mes-descricao = 'Janeiro'.
MODIFY ydbct_dla7_1 FROM ls_mes.

" Forma Inline de Inserir na Tabela
DATA(ls_mes_inline) = VALUE ydbct_dla7_1(
  mes       = 1
  descricao = 'Janeiro'
).
MODIFY ydbct_dla7_1 FROM ls_mes_inline.


" Forma Tradicional de Inserir por Tabela Interna
DATA: lt_mes TYPE TABLE OF ydbct_dla7_1.

ls_mes-mes = 1.
ls_mes-descricao = 'Janeiro'.
APPEND ls_mes TO lt_mes.

ls_mes-mes = 2.
ls_mes-descricao = 'Fevereiro'.
APPEND ls_mes TO lt_mes.

MODIFY ydbct_dla7_1 FROM TABLE lt_mes.

" Forma Inline de Inserir por Tabela Interna
DATA(lt_mes_inline) = VALUE tt_mes(
  ( mes = 1   descricao = 'Janeiro' )
  ( mes = 2   descricao = 'Fevereiro' )
  ( mes = 3   descricao = 'Março' )
  ( mes = 4   descricao = 'Abril' )
  ( mes = 5   descricao = 'Maio' )
  ( mes = 6   descricao = 'Junho' )
  ( mes = 7   descricao = 'Julho' )
  ( mes = 8   descricao = 'Agosto' )
  ( mes = 9   descricao = 'Setembro' )
  ( mes = 10  descricao = 'Outubro' )
  ( mes = 11  descricao = 'Novembro' )
  ( mes = 12  descricao = 'Dezembro' )
).
MODIFY ydbct_dla7_1 FROM TABLE lt_mes_inline.

" 1 Forma Clássica de Select
SELECT mandt, mes, descricao
  FROM ydbct_dla7_1
  INTO TABLE @lt_mes.

" 2 Forma Clássica de Select
SELECT mes, descricao
  FROM ydbct_dla7_1
  INTO CORRESPONDING FIELDS OF TABLE @lt_mes.

" 3 Forma Clássica de Select
SELECT *
  FROM ydbct_dla7_1
  INTO TABLE @lt_mes.

" 4 Forma Clássica de Select
SELECT *
  FROM ydbct_dla7_1
  INTO TABLE @lt_mes
  WHERE mes = 1.

" 5 Forma Clássica de Select
SELECT *
  FROM ydbct_dla7_1
  INTO TABLE @lt_mes
  WHERE mes BETWEEN 1 AND 7.

" 6 Forma Clássica de Select
SELECT *
  FROM ydbct_dla7_1
  INTO TABLE @lt_mes
  WHERE mes > 1
    AND mes <= 7.
" > , < , >=, <=, <>, =
" GT, LT, GE, LE, NE, EQ

" 7 Forma Inline de Select
SELECT *
  FROM ydbct_dla7_1
  INTO TABLE @DATA(lt_mes_inlines).

LOOP AT lt_mes_inlines INTO DATA(ls_mes_inlines).
  WRITE: / ls_mes_inlines-mes, ls_mes_inlines-descricao.
ENDLOOP.

READ TABLE lt_mes_inline
  INTO DATA(ls_read_mes)
  WITH KEY mes = 1.
WRITE: / 'Selecionando Linha: ', ls_read_mes-descricao.

WRITE: / 'Selecionando Linha Index: ', lt_mes_inline[ 4 ]-descricao.
