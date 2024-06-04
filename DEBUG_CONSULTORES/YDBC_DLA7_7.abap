*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_DLA7_7.


" Calculadora
INCLUDE YIDBC_DLA7_7_SCR. " Tela De Seleção
*INCLUDE YIDBC_DLA7_7_TOP. " Declarações Globais
*INCLUDE YIDBC_DLA7_7_PBO. " Eventos Antes de Exibir a Tela de Seleção
INCLUDE YIDBC_DLA7_7_PAI. " Eventos Depois de Exibir a Tela de Seleção

START-OF-SELECTION.
  WRITE: 'Soma: ', lv_soma.
