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
ENDCLASS.



CLASS ZDLPMCL_TEST_PROJECT IMPLEMENTATION.


  method FILLED.


    DATA(project) = VALUE zdlpmt_003(
        titulo        = 'Título'
        descricao     = 'Descrição'
        modulo        = 'FI'
        setor         = '1'
        equipe        = '1'
        responsavel   = 'ACCGFARIA'
        data_inicio   = '20221228'
        data_fim      = '20221231'
        data_fim_real = ''
      ).

    DATA(ls_result) = me->go_project->create(
      CHANGING
        is_data = project
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = 'Projeto Preenchido' ).

  endmethod.


  METHOD has_no_description.

    DATA(project) = VALUE zdlpmt_003(
        titulo        = 'Título'
        descricao     = ''
        modulo        = 'FI'
        setor         = '1'
        equipe        = '1'
        responsavel   = 'ACCGFARIA'
        data_inicio   = '20221228'
        data_fim      = '20221231'
        data_fim_real = ''
      ).

    DATA(ls_result) = me->go_project->create(
      CHANGING
        is_data = project
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = 'Projeto sem Descrição' ).

  ENDMETHOD.


  method HAS_NO_OWNER.

    DATA(project) = VALUE zdlpmt_003(
        titulo        = 'Título'
        descricao     = 'Descrição'
        modulo        = 'FI'
        setor         = '1'
        equipe        = '1'
        responsavel   = ''
        data_inicio   = '20221228'
        data_fim      = '20221231'
        data_fim_real = ''
      ).

    DATA(ls_result) = me->go_project->create(
      CHANGING
        is_data = project
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = 'Projeto sem Responsável' ).

  endmethod.


  method HAS_NO_SQUAD.

    DATA(project) = VALUE zdlpmt_003(
        titulo        = 'Título'
        descricao     = 'Descrição'
        modulo        = 'FI'
        setor         = '1'
        equipe        = ''
        responsavel   = 'ACCGFARIA'
        data_inicio   = '20221228'
        data_fim      = '20221231'
        data_fim_real = ''
      ).

    DATA(ls_result) = me->go_project->create(
      CHANGING
        is_data = project
    ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = 'Projeto sem Equipe' ).

  endmethod.


  METHOD has_no_title.

    DATA(project) = VALUE zdlpmt_003(
      descricao     = 'Descrição'
      modulo        = 'FI'
      setor         = '1'
      equipe        = '1'
      responsavel   = 'ACCGFARIA'
      data_inicio   = '20221228'
      data_fim      = '20221231'
      data_fim_real = ''
    ).

    DATA(ls_result) = me->go_project->create(
                        CHANGING
                          is_data = project
                      ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = 'Projeto sem título' ).

  ENDMETHOD.


  METHOD setup.

    me->go_project = NEW zdlpmcl_002( 'ZDLPMT_003' ).

  ENDMETHOD.


  method TEARDOWN.

    FREE: me->go_project.

  endmethod.
ENDCLASS.