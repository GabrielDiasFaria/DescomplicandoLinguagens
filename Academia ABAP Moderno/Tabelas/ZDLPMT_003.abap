@EndUserText.label : 'DLPM - Projetos'
@AbapCatalog.enhancementCategory : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #ALLOWED
define table zdlpmt_003 {
  key mandt     : mandt not null;
  key id        : zdlpmel_005 not null;
  titulo        : zdlpmel_006;
  descricao     : zdlpmel_007;
  modulo        : zdlpmel_003;
  setor         : zdlpmel_001;
  equipe        : zdlpmel_008;
  responsavel   : uname;
  data_inicio   : dats;
  data_fim      : dats;
  data_fim_real : dats;
  include zdlpmcaes_001;

}