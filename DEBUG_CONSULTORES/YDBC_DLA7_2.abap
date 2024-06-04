*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_DLA7_2.


" Variáveis Primitivas
" Número 1
" Número 2
" Resultado

" gv = Global Variable | Variáveis Globais
DATA gv_num_1     TYPE i. " i = Inteiro
DATA gv_num_2     TYPE i.
DATA gv_resultado TYPE i.
DATA gv_texto     TYPE string.

gv_texto = 'Resultado: '.

gv_num_1 = 5.
gv_num_2 = 10.
gv_resultado = gv_num_1 + gv_num_2.
WRITE: gv_texto, gv_resultado.

gv_num_1 = 15.
gv_num_2 = 15.
gv_resultado = gv_num_1 + gv_num_2.
WRITE: / gv_texto, gv_resultado.

" Variáveis Estrutura
" TYPES -> Declarar Tipos
TYPES: BEGIN OF ty_strutura,  " BEGIN OF -> Início do Tipo
        num_1     TYPE i,     " Coluna com o Tipo Primitivo
        num_2     TYPE i,     " Coluna com o Tipo Primitivo
        resultado TYPE i,     " Coluna com o Tipo Primitivo
        texto     TYPE string," Coluna com o Tipo Primitivo
       END OF ty_strutura.    " END OF -> Fim do Tipo

" gs = Global Structure | Estrutura Global
DATA gs_calculadora   TYPE ty_strutura.
DATA gs_calculadora_2 TYPE ty_strutura.

gs_calculadora-num_1 = 10.
gs_calculadora-num_2 = 15.
gs_calculadora-resultado = gs_calculadora-num_1 + gs_calculadora-num_2.
gs_calculadora-texto = 'Resultado Esutura: '.

WRITE: / gs_calculadora-texto, gs_calculadora-resultado.

gs_calculadora_2-num_1 = 1.
gs_calculadora_2-num_2 = 1.
gs_calculadora_2-resultado = gs_calculadora_2-num_1 + gs_calculadora_2-num_2.
gs_calculadora_2-texto = 'Resultado Esutura 2: '.

WRITE: / gs_calculadora_2-texto, gs_calculadora_2-resultado.

" Variáveis Tabelas
" gt = Global Table | Tabela Global
DATA gt_calculadora TYPE TABLE OF ty_strutura.

" Numero 1 | Numero 2 | Resultado | Texto
" 1        | 2        | 3         | Resultado Tabela:
" 5        | 5        | 10        | Resultado Tabela:

gs_calculadora-num_1 = 1.
gs_calculadora-num_2 = 2.
gs_calculadora-resultado = gs_calculadora-num_1 + gs_calculadora-num_2.
gs_calculadora-texto = 'Resultado Tabela: '.
APPEND gs_calculadora TO gt_calculadora.

gs_calculadora-num_1 = 5.
gs_calculadora-num_2 = 5.
gs_calculadora-resultado = gs_calculadora-num_1 + gs_calculadora-num_2.
gs_calculadora-texto = 'Resultado Tabela: '.
APPEND gs_calculadora TO gt_calculadora.


WRITE: / gt_calculadora[ 1 ]-texto, gt_calculadora[ 1 ]-resultado.
WRITE: / gt_calculadora[ 2 ]-texto, gt_calculadora[ 2 ]-resultado.
