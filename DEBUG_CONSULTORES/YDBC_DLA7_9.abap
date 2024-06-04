*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_9
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_DLA7_9.

CLASS lc_email DEFINITION.
  PUBLIC SECTION.
    DATA: destinatario TYPE string,
          assunto      TYPE string,
          remetente    TYPE string.

    METHODS: send_email.

ENDCLASS.

CLASS lc_email IMPLEMENTATION.

  METHOD send_email.
    WRITE: / 'Email enviado para ', destinatario.
  ENDMETHOD.

ENDCLASS.

" Acessar coisas dentro da minha classe
"
INITIALIZATION.
  DATA(lo_email) = NEW lc_email( ).
  lo_email->assunto       = 'Notificação de Compra'.
  lo_email->destinatario  = 'carlos@hotmail.com'.
  lo_email->remetente     = 'sap@sap.com'.
  lo_email->send_email( ).
