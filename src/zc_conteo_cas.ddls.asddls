@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Compsumption Cabecera de Conteo'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: [ 'CountUUID' ]
define root view entity zc_conteo_cas
provider contract transactional_query
  as projection on zr_conteo_head_cas
{
  key CountUUID,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      CountType,
      CountTypeText,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Plant,
      Status,
      CountDate,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.user.lastChangedBy: true
      LastChangedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      LocalLastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      /* Associations */
      _DetalleConteo : redirected to composition child zc_det_conteo_cas
}
