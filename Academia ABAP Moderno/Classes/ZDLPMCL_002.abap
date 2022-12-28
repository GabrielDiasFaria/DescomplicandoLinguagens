class ZDLPMCL_002 definition
  public
  inheriting from ZDLPMCL_001
  final
  create public .

public section.

  methods VALIDATE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZDLPMCL_002 IMPLEMENTATION.


  METHOD validate.

    DATA(ls_projeto) = CORRESPONDING zdlpmt_003( is_data ).

    " Não pode Salvar Projeto sem ID
    IF ls_projeto-id IS INITIAL.
      RAISE EXCEPTION NEW zdlpmcl_003(
        textid = zdlpmcl_003=>has_no_id
      ).
    ENDIF.

    " Não pode Salvar Projeto sem Título
    IF ls_projeto-titulo IS INITIAL.
      RAISE EXCEPTION NEW zdlpmcl_003(
        textid = zdlpmcl_003=>has_no_title
      ).
    ENDIF.

    " Não pode Salvar Projeto sem Equipe
    IF ls_projeto-equipe IS INITIAL.
      RAISE EXCEPTION NEW zdlpmcl_003(
        textid = zdlpmcl_003=>has_no_squad
      ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.