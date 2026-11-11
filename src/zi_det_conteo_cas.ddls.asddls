@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface Detalle de Conteo'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_det_conteo_cas
  as projection on zr_det_conteo_cas
{
  key ItemUUID,
      CountUUID,
      Material,
      StorageLocation,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      BookQty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      CountQty,
      Unit,
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
      _Conteo: redirected to parent zi_conteo_head_cas
}
