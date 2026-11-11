@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface Cabecera de Conteo'
@Metadata.ignorePropagatedAnnotations: true

define root view entity zi_conteo_head_cas
provider contract transactional_interface
  as projection on zr_conteo_head_cas 
{
  key CountUUID,
      CountType,
      Plant,
      Status,
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
      _DetalleConteo: redirected to composition child zi_det_conteo_cas
}
