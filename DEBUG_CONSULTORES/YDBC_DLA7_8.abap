*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_DLA7_8.


PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i.

START-OF-SELECTION.
  PERFORM soma.
  PERFORM subtracao.
  PERFORM multiplicacao.
  PERFORM divisao.


FORM soma.

  DATA(lv_return_soma) = p_num1 + p_num2.
  WRITE: / 'Resultado: ', lv_return_soma.

ENDFORM.

FORM subtracao.

  DATA(lv_return_subtracao) = p_num1 - p_num2.
  WRITE: / 'Resultado: ', lv_return_subtracao.

ENDFORM.

FORM multiplicacao.

  DATA(lv_return_multiplicacao) = p_num1 * p_num2.
  WRITE: / 'Resultado: ', lv_return_multiplicacao.

ENDFORM.

FORM divisao.

  DATA(lv_return_divisao) = p_num1 / p_num2.
  WRITE: / 'Resultado: ', lv_return_divisao.

ENDFORM.
