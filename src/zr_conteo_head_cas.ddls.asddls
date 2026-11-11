@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Root Cabecera de Conteo'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_conteo_head_cas
  as select from zconteo_head_cas
  composition [0..*] of zr_det_conteo_cas as _DetalleConteo
{
  key count_uuid            as CountUUID,
      count_type            as CountType,
      plant                 as Plant,
      status                as Status,

      //      Campos Auditoría de Usuario
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,


      //      Campos Auditoría Fechas
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,

      //    Etag
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      //    Total Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      //      Asociaciones
      _DetalleConteo
}
