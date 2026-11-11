@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Root Detalle de Conteo'
@Metadata.ignorePropagatedAnnotations: true
define view entity zr_det_conteo_cas
  as select from zconteo_item_cas 
  association to parent zr_conteo_head_cas as _Conteo on $projection.CountUUID = _Conteo.CountUuid
{
  key item_uuid             as ItemUUID,
      count_uuid            as CountUUID,
      material              as Material,
      storage_location      as StorageLocation,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      book_qty              as BookQty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      count_qty             as CountQty,
      unit                  as Unit,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      //      Etag
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      //      Total Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      //      Asociaciones
      _Conteo
}
