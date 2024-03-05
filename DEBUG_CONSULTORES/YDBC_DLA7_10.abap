*&---------------------------------------------------------------------*
*& Report YDBC_DLA7_10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_DLA7_10.

DATA(lo_email) = NEW zcl_email( ).
  lo_email->assunto       = 'Notificação de Compra'.
  lo_email->destinatario  = 'carlos@hotmail.com'.
  lo_email->remetente     = 'sap@sap.com'.
  lo_email->send_email( EXPORTING send_immed = 'X' ).
