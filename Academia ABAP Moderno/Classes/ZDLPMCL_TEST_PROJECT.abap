class ZDLPMCL_TEST_PROJECT definition
  public
  final
  create public
  for testing
  risk level harmless .

public section.

  data GO_PROJECT type ref to ZDLPMCL_002 .
protected section.
private section.

  methods SETUP .
  methods TEARDOWN .
  methods HAS_NO_TITLE
  for testing
    raising
      ZDLPMCL_003 .
  methods HAS_NO_DESCRIPTION
  for testing
    raising
      ZDLPMCL_003 .
  methods HAS_NO_SQUAD
  for testing
    raising
      ZDLPMCL_003 .
  methods HAS_NO_OWNER
  for testing
    raising
      ZDLPMCL_003 .
  methods FILLED
  for testing
    raising
      ZDLPMCL_003 .
  methods EDIT
  for testing
    raising
      ZDLPMCL_003 .
  methods DELETE
  for testing
    raising
      ZDLPMCL_003 .
ENDCLASS.



CLASS ZDLPMCL_TEST_PROJECT IMPLEMENTATION.


  method FILLED.


    DATA(project) = VALUE zdlpmt_003(
        titulo        = `Título`
        descricao     = `Descrição`
        modulo        = `FI`
        setor         = '1'
        equipe        = '1'
        responsavel   = `ACCGFARIA`
        data_inicio   = `20221228`
        data_fim      = `20221231`
        data_fim_real = ''
      ).

    DATA(ls_result) = me->go_project->create(
      CHANGING
        is_data = project
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).

  endmethod.


  METHOD has_no_description.

    DATA(project) = VALUE zdlpmt_003(
        titulo        = `Título`
        descricao     = ''
        modulo        = `FI`
        setor         = '1'
        equipe        = '1'
        responsavel   = `ACCGFARIA`
        data_inicio   = `20221228`
        data_fim      = `20221231`
        data_fim_real = ''
      ).

    DATA(ls_result) = me->go_project->create(
      CHANGING
        is_data = project
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).

  ENDMETHOD.


  method HAS_NO_OWNER.

    DATA(project) = VALUE zdlpmt_003(
        titulo        = `Título`
        descricao     = `Descrição`
        modulo        = `FI`
        setor         = '1'
        equipe        = '1'
        responsavel   = ''
        data_inicio   = `20221228`
        data_fim      = `20221231`
        data_fim_real = ''
      ).

    DATA(ls_result) = me->go_project->create(
      CHANGING
        is_data = project
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).

  endmethod.


  method HAS_NO_SQUAD.

    DATA(project) = VALUE zdlpmt_003(
        titulo        = `Título`
        descricao     = `Descrição`
        modulo        = `FI`
        setor         = '1'
        equipe        = ''
        responsavel   = `ACCGFARIA`
        data_inicio   = `20221228`
        data_fim      = `20221231`
        data_fim_real = ''
      ).

    DATA(ls_result) = me->go_project->create(
      CHANGING
        is_data = project
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).

  endmethod.


  METHOD has_no_title.

    DATA(project) = VALUE zdlpmt_003(
      descricao     = `Descrição`
      modulo        = `FI`
      setor         = '1'
      equipe        = '1'
      responsavel   = `ACCGFARIA`
      data_inicio   = `20221228`
      data_fim      = `20221231`
      data_fim_real = ''
    ).

    DATA(ls_result) = me->go_project->create(
                        CHANGING
                          is_data = project
                      ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).

  ENDMETHOD.


  METHOD setup.

    me->go_project = NEW zdlpmcl_002( 'ZDLPMT_003' ).

  ENDMETHOD.


  method TEARDOWN.

    FREE: me->go_project.

  endmethod.


  METHOD delete.

*   Declarar um Sucesso
    DATA(project) = VALUE zdlpmt_003(
        titulo        = `Título`
        descricao     = `Descrição`
        modulo        = `FI`
        setor         = '1'
        equipe        = '1'
        responsavel   = `ACCGFARIA`
        data_inicio   = `20221228`
        data_fim      = `20221231`
        data_fim_real = ''
      ).

*   Criar um Projeto
    DATA(ls_result_create) = me->go_project->create(
      CHANGING
        is_data = project
    ).

*   Modificar o Projeto
    project-id        = ls_result_create-message_v1.
    project-descricao = `Deleted`.

    DATA(ls_result_delete) = me->go_project->delete( project ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_delete-type exp = 'S' msg = ls_result_delete-message ).

  ENDMETHOD.


  method EDIT.

*   Declarar um Sucesso
    DATA(project) = VALUE zdlpmt_003(
        titulo        = `Título`
        descricao     = `Descrição`
        modulo        = `FI`
        setor         = '1'
        equipe        = '1'
        responsavel   = `ACCGFARIA`
        data_inicio   = `20221228`
        data_fim      = `20221231`
        data_fim_real = ''
      ).

*   Criar um Projeto
    DATA(ls_result_create) = me->go_project->create(
      CHANGING
        is_data = project
    ).

*   Modificar o Projeto
    project-id        = ls_result_create-message_v1.
    project-descricao = `Modified`.

    DATA(ls_result_update) = me->go_project->update(
      CHANGING
        is_data = project
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_update-type exp = 'S' msg = ls_result_update-message ).

  endmethod.
ENDCLASS.