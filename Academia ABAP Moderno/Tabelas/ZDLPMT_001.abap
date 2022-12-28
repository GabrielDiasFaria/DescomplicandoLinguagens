@EndUserText.label : 'DLPM - Setor Empresa'
@AbapCatalog.enhancementCategory : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #ALLOWED
define table zdlpmt_001 {
  key mandt : mandt not null;
  key setor : zdlpmel_001 not null;
  descricao : zdlpmel_002;
  include zdlpmcaes_001;

}