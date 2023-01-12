
WRITE 'Olá Mundo!'.
WRITE / 'Olá Mundo 2!'.

* Variáveis (INT, CHAR, STRING, DATE, TIME, DECIMAL)
" Tipo 2 de Comentários

* INT - Inteiros (1, 2, 3, 4, 5, 6, 7, ...)
DATA: numero1   TYPE i,
      numero2   TYPE i,
      resultado TYPE i.

numero1 = 10.
numero2 = 20.
resultado = 10 + 20.

WRITE: / 'Número 1: ', numero1.
WRITE: / 'Número 2: ', numero2.
WRITE: / 'Resultado: ', resultado.

* CHAR - Texto de 1 Posição
DATA: sexo TYPE c.

sexo = 'M'.
WRITE: / 'Sexo: ', sexo.

* STRING - Texto 256 Caracteres
DATA: mensagem TYPE string.

mensagem = 'O SAP é muito TOP!'.
WRITE: / 'Mensagem: ', mensagem.

* DATE - Data do Calendário
DATA: aniversario TYPE dats,
      data_atual  TYPE dats.

aniversario = '19920412'.
WRITE: / 'Data Aniversário: ', aniversario.

data_atual = sy-datum.
WRITE: / 'Data Atual: ', data_atual.

* TIME - Horário do Relógio
DATA: hora_video TYPE uzeit,
      hora_atual TYPE uzeit.

hora_video = '222600'.
WRITE: / 'Hora Vídeo: ', hora_video.

hora_atual = sy-uzeit.
WRITE: / 'Hora Atual: ', hora_atual.

* DECIMAL - Números com casas decimais
DATA: valor_iphone TYPE p DECIMALS 2.

valor_iphone = '1122.20'.
WRITE: / 'Valor Iphone: ', valor_iphone.

* CONSTANTS - Variáveis que não modificam o valor
CONSTANTS: type_error TYPE c VALUE 'E'.

* RANGES - Intervalos de Valores
RANGES: intervalo_data FOR sy-datum.

* - SIGN   -> E - Exclude | I - Include
* - OPTION -> EQ - Igual | BT - Entre | NE - Não Igual
* - LOW    -> Valor De
* - HIGH   -> Valor Até
intervalo_data-sign   = 'I'.
intervalo_data-option = 'BT'.
intervalo_data-low    = '20220101'.
intervalo_data-high   = '20230101'.


* ESTRUTURAS - Variáveis com Colunas
* Dados de um Cliente
* Nome Completo, Data Nascimento, Email
TYPES: BEGIN OF ty_cliente,
        nome_completo   TYPE string,
        data_nascimento TYPE dats,
        email           TYPE string,
       END OF ty_cliente.
DATA: cliente  TYPE ty_cliente,
      cliente2 TYPE ty_cliente.
cliente-nome_completo   = 'Gabriel Dias Faria'.
cliente-data_nascimento = '19920412'.
cliente-email           = 'gabrieldiasfaria@gmail.com'.

WRITE: / 'O Cliente ', cliente-nome_completo,
         ' nasceu em ', cliente-data_nascimento,
         ' e tem o email ', cliente-email.

WRITE: / 'O Cliente2 ', cliente2-nome_completo,
         ' nasceu em ', cliente2-data_nascimento,
         ' e tem o email ', cliente2-email.

* TABLES - Tabelas (Possui Linhas com estruturas definidas)
DATA: clientes TYPE TABLE OF ty_cliente.
APPEND cliente TO clientes.

APPEND VALUE ty_cliente(
  nome_completo   = 'Pedro'
  data_nascimento = '20230101'
  email           = 'pedro@gmail.com'
) TO clientes.

* Condições - IF
DATA: numero_if TYPE i.
numero_if = 2.

IF numero_if = 2.
  WRITE: / 'Número IF é 2'.
ELSE.
  WRITE: / 'Número IF não é 2'.
ENDIF.

DATA(validacao_if) = xsdbool( numero_if = 2 ).
WRITE: / validacao_if.

IF numero_if >= 1 AND numero_if <= 10.
  WRITE: / 'Dentro do Range'.
ENDIF.

DATA(validacao_if2) = xsdbool( numero_if = 2 OR numero_if = 3 ).
WRITE: / validacao_if2.

IF xsdbool( numero_if = 2 OR numero_if = 3 ) = 'X'.
  WRITE: / 'Entrou na Regra 2 ou 3'.
ENDIF.

CHECK numero_if = 2.

WRITE: / 'Continua o programa'.

* Condições CASE
DATA: case_number TYPE i VALUE 3.
CASE case_number.
    WHEN 2.
      WRITE: / 'CASE - é 2'.
    WHEN 3.
      WRITE: / 'CASE - é 3'.
    WHEN OTHERS.
ENDCASE.

* LOOP - Percorrer linhas de uma tabela
TYPES: ty_interger TYPE TABLE OF i WITH DEFAULT KEY.
DATA(tabela) = VALUE ty_interger( ( 1 ) ( 2 ) ( 3 ) ( 4 ) ).

LOOP AT tabela INTO DATA(linha).
  WRITE: / 'Linha - ', linha.
ENDLOOP.

* DO - Percorre N vezes
DO 5 TIMES.
  WRITE: / 'DO - ', 2.
ENDDO.

* READ TABLE - Ler uma Linha de uma Tabela
READ TABLE tabela INTO DATA(read_line) INDEX 2.
WRITE: / 'READ TABLE - ', read_line.

READ TABLE clientes INTO DATA(gabriel) WITH KEY nome_completo = 'Gabriel Dias Faria'.
WRITE: / 'READ TABLE - ', gabriel-nome_completo, gabriel-data_nascimento.

* Limpar Valores das Variáveis
CLEAR: cliente, cliente2.

* MOVE-CORRESPONDING - Mover valores de uma estrutura para a outra
cliente-nome_completo = 'Gabriel Dias Faria'.
WRITE: / cliente-nome_completo, ' - ', cliente2-nome_completo.
MOVE-CORRESPONDING cliente TO cliente2.
WRITE: / cliente-nome_completo, ' - ', cliente2-nome_completo.

* Variáveis SY - Variáveis do Servidor
WRITE:
  / 'Data Servidor: ', sy-datum,
  / 'Hora Servidor: ', sy-uzeit,
  / 'Nome Servidor: ', sy-sysid,
  / 'Usuário Logado: ', sy-uname,
  / 'Nome Programa: ', sy-cprog,
  / 'Titulo Programa: ', sy-title
.