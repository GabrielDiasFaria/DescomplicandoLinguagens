*&---------------------------------------------------------------------*
*& Report ZFAJR_DLA7_RP_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfajr_dla7_rp_3.

" Relatório de Qtd Caixas por Venda
" 1- Seleção de Dados
"   - Venda, Caixa, Produto
"     - Vendas
"       - Produtos (Volume)
"         - Caixas (Dividir Total Volume)
" 2- Manipulação de Dados
"   - Calcular o Volume por Venda
"   - Calcular a Quantidade de Caixas
" 3- Exibição de Dados
"   - Exibir a Quantidade de Caixas

TABLES: zfajr_dla7_3.

" Filtros - Tela de Seleção
SELECT-OPTIONS: so_ped FOR zfajr_dla7_3-id.



CLASS lcl_report DEFINITION.

  PUBLIC SECTION.

    DATA: lt_pedido      TYPE TABLE OF zfajr_dla7_3,
          lt_pedido_item TYPE TABLE OF zfajr_dla7_4.
    DATA: lt_produto     TYPE TABLE OF zfajr_dla7_2.
    DATA: lt_caixa       TYPE TABLE OF zfajr_dla7_1.

    TYPES: BEGIN OF ty_calc_vol_venda,
            id           TYPE zfajr_dla7_el_1,
            volume_total TYPE int4,
           END OF ty_calc_vol_venda.
    DATA: lt_volume_venda TYPE TABLE OF ty_calc_vol_venda.

    TYPES: BEGIN OF ty_calc_qtd_caixa,
            id           TYPE zfajr_dla7_el_1,
            volume_total TYPE int4,
            qtd_caixa_p  TYPE int4,
            qtd_caixa_m  TYPE int4,
            qtd_caixa_l  TYPE int4,
            qtd_caixa_xl TYPE int4,
           END OF ty_calc_qtd_caixa.
    DATA: lt_qtd_caixa TYPE TABLE OF ty_calc_qtd_caixa,
          ls_qtd_caixa TYPE ty_calc_qtd_caixa.

    METHODS: run,
      get_pedidos,
      get_produtos,
      get_caixas,
      calcular_volume_venda,
      calcular_quantidade_caixas,
      exibir_relatorio.

ENDCLASS.

CLASS lcl_report IMPLEMENTATION.

  METHOD run.

    get_pedidos( ).
    get_produtos( ).
    get_caixas( ).

    calcular_volume_venda( ).
    calcular_quantidade_caixas( ).

    exibir_relatorio( ).

  ENDMETHOD.

  METHOD get_pedidos.

    SELECT *
      FROM zfajr_dla7_3
      INTO TABLE @lt_pedido
      WHERE id IN @so_ped.

    " Verifica se Achou Vendas
    IF lt_pedido[] IS NOT INITIAL.

      SELECT *
        FROM zfajr_dla7_4
        INTO TABLE @lt_pedido_item
        FOR ALL ENTRIES IN @lt_pedido
        WHERE id = @lt_pedido-id.

    ENDIF.

  ENDMETHOD.

  METHOD get_produtos.

    CHECK lt_pedido_item[] IS NOT INITIAL.

    SELECT *
      FROM zfajr_dla7_2
      INTO TABLE @lt_produto
      FOR ALL ENTRIES IN @lt_pedido_item
      WHERE id = @lt_pedido_item-produto.

  ENDMETHOD.

  METHOD get_caixas.

    SELECT *
      FROM zfajr_dla7_1
      INTO TABLE @lt_caixa
      ORDER BY volume DESCENDING.

  ENDMETHOD.

  METHOD calcular_volume_venda.

    " Multiplicar o Volume do Produto pela Quantidade do Pedido
    " ID Venda, Volume Total

    DATA: lv_soma_volume TYPE int4.

    LOOP AT lt_pedido INTO DATA(ls_pedido).

      " Itens do Pedido em Questão
      LOOP AT lt_pedido_item
        INTO DATA(ls_pedido_item)
        WHERE id = ls_pedido-id.

        " Buscamos o Produto do Item do Pedido
        READ TABLE lt_produto
          INTO DATA(ls_produto)
          WITH KEY id = ls_pedido_item-produto.

        lv_soma_volume += ls_produto-volume * ls_pedido_item-quantidade.

        CLEAR: ls_pedido_item, ls_produto.

      ENDLOOP.

      APPEND VALUE #(
        id           = ls_pedido-id
        volume_total = lv_soma_volume
      ) TO lt_volume_venda.

      CLEAR: lv_soma_volume, ls_pedido.

    ENDLOOP.

  ENDMETHOD.

  METHOD calcular_quantidade_caixas.

    " Dividir o Volume Total do Pedido nas Caixas do Sistema
    " ID Venda, Quantidade Caixas Pequenas, Médias, Grandes e Extra Grandes

    LOOP AT lt_volume_venda INTO DATA(ls_volume_venda).

      " Total - 34
*      CAIXA EXTRA GRANDE - 50
*      CAIXA GRANDE	      - 30
*      CAIXA MÉDIA        - 15
*      CAIXA PEQUENA      - 5

      DATA(lv_volume_total) = ls_volume_venda-volume_total.

      LOOP AT lt_caixa INTO DATA(ls_caixa).
        DATA(lv_tabix) = sy-tabix. " Linha Atual do Loop

        " DIV - Pega o Valor da Divisão
        " Quantidade de Caixas
        DATA(lv_div) = lv_volume_total DIV ls_caixa-volume.

        " MOD - Pega o Resto da Divisão
        " Quantidade de Volume que Sobra
        DATA(lv_mod) = lv_volume_total MOD ls_caixa-volume.

        " Encaixa o Resto na Caixa Pequena
        IF lv_tabix = LINES( lt_caixa ) AND lv_mod IS NOT INITIAL.
          lv_div += 1.
        ENDIF.

        CASE ls_caixa-id.
          WHEN 1. " Pequena
            ls_qtd_caixa-qtd_caixa_p = lv_div.
          WHEN 2. " Média
            ls_qtd_caixa-qtd_caixa_m = lv_div.
          WHEN 3. " Grande
            ls_qtd_caixa-qtd_caixa_l = lv_div.
          WHEN OTHERS. " Extra Grande
            ls_qtd_caixa-qtd_caixa_xl = lv_div.
        ENDCASE.

        lv_volume_total = lv_mod.

        CLEAR: lv_div, lv_mod.

      ENDLOOP.

      ls_qtd_caixa-id           = ls_volume_venda-id.
      ls_qtd_caixa-volume_total = ls_volume_venda-volume_total.
      APPEND ls_qtd_caixa TO lt_qtd_caixa.

      CLEAR: ls_volume_venda, ls_qtd_caixa, lv_volume_total.

    ENDLOOP.

  ENDMETHOD.

  METHOD exibir_relatorio.

    DATA: lo_column TYPE REF TO cl_salv_column.

    cl_salv_table=>factory(
        IMPORTING
          r_salv_table = DATA(lo_alv)
        CHANGING
          t_table      = lt_qtd_caixa[] ).

    DATA(lo_cols) = lo_alv->get_columns( ).

    lo_column ?= lo_cols->get_column( 'VOLUME_TOTAL' ).
    lo_column->set_long_text( 'Volume Total' ).

    lo_column ?= lo_cols->get_column( 'QTD_CAIXA_P' ).
    lo_column->set_long_text( 'Qtd Caixa P' ).

    lo_column ?= lo_cols->get_column( 'QTD_CAIXA_M' ).
    lo_column->set_long_text( 'Qtd Caixa M' ).

    lo_column ?= lo_cols->get_column( 'QTD_CAIXA_L' ).
    lo_column->set_long_text( 'Qtd Caixa L' ).

    lo_column ?= lo_cols->get_column( 'QTD_CAIXA_XL' ).
    lo_column->set_long_text( 'Qtd Caixa XL' ).

    lo_alv->display( ).

  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.
  DATA(lo_report) = NEW lcl_report( ).
  lo_report->run( ).
