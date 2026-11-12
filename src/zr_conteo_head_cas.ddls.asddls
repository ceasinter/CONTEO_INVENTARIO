@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Root Cabecera de Conteo'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_conteo_head_cas
  as select from zconteo_head_cas
  composition [0..*] of zr_det_conteo_cas as _DetalleConteo
{
  key count_uuid            as CountUUID,

      @EndUserText.label: 'Tipo de Conteo'
      @ObjectModel.text.element: [ 'CountTypeText' ]
      count_type            as CountType,
      @EndUserText.label: 'Descripción Conteo'
      case count_type
        when 'C' then 'Cíclico'
        when 'G' then 'General'
        else 'Desconocido'
      end                   as CountTypeText,
      plant                 as Plant,
      status                as Status,
      count_date            as CountDate,

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
