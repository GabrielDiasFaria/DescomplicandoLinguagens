*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_DLA7_4.

*DO 12 TIMES.
*  CASE sy-index.
*    WHEN 1.
*      WRITE: / 'Janeiro'.
*    WHEN 2.
*      WRITE: / 'Fevereiro'.
*    WHEN 3.
*      WRITE: / 'Março'.
*    WHEN 4.
*      WRITE: / 'Abril'.
*    WHEN 5.
*      WRITE: / 'Maio'.
*    WHEN 6.
*      WRITE: / 'Junho'.
*    WHEN 7.
*      WRITE: / 'Julho'.
*    WHEN 8.
*      WRITE: / 'Agosto'.
*    WHEN 9.
*      WRITE: / 'Setembro'.
*    WHEN 10.
*      WRITE: / 'Outrubro'.
*    WHEN 11.
*      WRITE: / 'Novembro'.
*    WHEN 12.
*      WRITE: / 'Dezembro'.
*    WHEN OTHERS.
*  ENDCASE.
*ENDDO.

DATA: gt_months TYPE TABLE OF string,
      gs_months TYPE string.

APPEND 'Janeiro' TO gt_months.
APPEND 'Fevereiro' TO gt_months.
APPEND 'Março' TO gt_months.
APPEND 'Abril' TO gt_months.
APPEND 'Maio' TO gt_months.
APPEND 'Junho' TO gt_months.
APPEND 'Julho' TO gt_months.
APPEND 'Agosto' TO gt_months.
APPEND 'Setembro' TO gt_months.
APPEND 'Outubro' TO gt_months.
APPEND 'Novembro' TO gt_months.
APPEND 'Dezembro' TO gt_months.

LOOP AT gt_months INTO gs_months.
  " Utilizar a GS para minha Lógica
  WRITE: / gs_months.

  CASE gs_months.
    WHEN 'Janeiro'.
      WRITE: ' - Inicio...'.
    WHEN 'Dezembro'.
      WRITE: ' - Fim...'.
    WHEN OTHERS.
  ENDCASE.
ENDLOOP.
