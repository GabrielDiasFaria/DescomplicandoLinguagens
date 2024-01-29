*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_DLA7_3.

DATA: lv_altura TYPE p DECIMALS 2,
      lv_genero TYPE string.

* Regra:
" Se Altura Menor que 1.60 = Mostrar na Tela Texto = Baixo
" Se Altura Entre 1.60 - 1.80 = Mostrar Texto = Médio
" Se Altura Maior Igual 1.81 = Mostrar Texto = Alto

lv_altura = '1.82'.

*IF lv_altura < '1.60'.
*  WRITE: '-> Baixo.'.
*ENDIF.
*
*IF lv_altura >= '1.60' AND lv_altura <= '1.80'.
*  WRITE: '-> Médio.'.
*ENDIF.
*
*IF lv_altura >= '1.81'.
*  WRITE: '-> Alto.'.
*ENDIF.

IF lv_altura < '1.60'.
  WRITE: '-> Baixo'.
ELSEIF lv_altura >= '1.60' AND lv_altura <= '1.80'.
  WRITE: '-> Médio'.
ELSE.
  WRITE: '-> Alto'.
ENDIF.

lv_genero = 'F'. " M - Masculino | F - Feminino

CASE lv_genero.
  WHEN 'M'.
    WRITE: / '-> Masculino'.
  WHEN 'F'.
    WRITE: / '-> Feminino'.
  WHEN OTHERS.
    WRITE: / '-> Outro'.
ENDCASE.
