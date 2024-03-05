*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_DLA7_6.

TABLES: sflight.

PARAMETERS: p_idade TYPE int4.

SELECTION-SCREEN: SKIP 1.

SELECT-OPTIONS: s_connid FOR sflight-connid.

SELECTION-SCREEN: SKIP 1.

PARAMETERS: r_analit RADIOBUTTON GROUP g1,
            r_sintet RADIOBUTTON GROUP g1,
            r_all    RADIOBUTTON GROUP g1.

SELECTION-SCREEN: SKIP 1.

PARAMETERS: c_test AS CHECKBOX,
            c_succ AS CHECKBOX,
            c_erro AS CHECKBOX,
            c_all  AS CHECKBOX.

SELECTION-SCREEN: PUSHBUTTON /2(10) button1 USER-COMMAND bt1.

SELECTION-SCREEN: SKIP 1.

INITIALIZATION.
  button1 = 'Bt 1'.
