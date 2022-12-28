@EndUserText.label : 'DLPM - Modulo SAP'
@AbapCatalog.enhancementCategory : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #ALLOWED
define table zdlpmt_002 {
  key mandt  : mandt not null;
  key modulo : zdlpmel_003 not null;
  include zdlpmcaes_001;

}