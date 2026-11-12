CLASS lhc_Conteo DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      keys REQUEST requested_features FOR Conteo RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Conteo RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Conteo RESULT result.

    METHODS precheck_create FOR PRECHECK
       entities FOR CREATE Conteo.

    METHODS precheck_update FOR PRECHECK
       entities FOR UPDATE Conteo.

    METHODS acceptConteo FOR MODIFY
       keys FOR ACTION Conteo~acceptConteo RESULT result.

    METHODS AdditionalSave FOR MODIFY
       keys FOR ACTION Conteo~AdditionalSave.
    METHODS setInitialStatus FOR DETERMINE ON SAVE
       keys FOR Conteo~setInitialStatus.

    METHODS validateQuantities FOR VALIDATE ON SAVE
       keys FOR Conteo~validateQuantities.

ENDCLASS.

CLASS lhc_Conteo IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD precheck_create.
  ENDMETHOD.

  METHOD precheck_update.
  ENDMETHOD.

  METHOD acceptConteo.
  ENDMETHOD.

  METHOD AdditionalSave.
  ENDMETHOD.

  METHOD setInitialStatus.
    " 1) Leer las entidades afectadas (las que se acaban de crear)
    READ ENTITIES OF zr_conteo_head_cas IN LOCAL MODE
      ENTITY Conteo
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_counts).

    " 2) Filtrar solo las que NO tienen estado aún
    "    (evita sobreescribir un estado si la entidad ya existía)
    DELETE lt_counts WHERE status IS NOT INITIAL.

    CHECK lt_counts IS NOT INITIAL.

    " 3) Preparar estructura de modificación
    DATA lt_modify TYPE TABLE FOR UPDATE zr_conteo_head_cas\\Conteo.

    lt_modify = VALUE #(
      FOR ls_count IN lt_counts (
        %tky   = ls_count-%tky
        status = 'AB'   " Abierto
      )
    ).

    " 4) Aplicar la modificación en modo local (no dispara otros eventos)
    MODIFY ENTITIES OF zr_conteo_head_cas IN LOCAL MODE
      ENTITY Conteo
        UPDATE FIELDS ( status )
        WITH lt_modify
      REPORTED DATA(lt_reported).

  ENDMETHOD.

  METHOD validateQuantities.
   " 1) Leer las cabeceras afectadas con sus ítems (asociación)
    READ ENTITIES OF zr_conteo_head_cas IN LOCAL MODE
      ENTITY Conteo
        FIELDS ( CountUUID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_counts).

    CHECK lt_counts IS NOT INITIAL.

    " 2) Leer los ítems de esas cabeceras
    READ ENTITIES OF zr_conteo_head_cas IN LOCAL MODE
      ENTITY Conteo BY \_DetalleConteo
        FIELDS ( CountQty material BookQty )
        WITH CORRESPONDING #( lt_counts )
      RESULT DATA(lt_items).

    " 3) Validar: cantidad contada no puede ser negativa
    LOOP AT lt_items INTO DATA(ls_item).

      " Saltar los que aún no tienen conteo (valor inicial)
      CHECK ls_item-CountQty IS NOT INITIAL.

      IF ls_item-CountQty < 0.

        " 4) Asociar el mensaje al campo problemático del ítem
        APPEND VALUE #(
          %tky        = ls_item-%tky
          %element-CountQty = if_abap_behv=>mk-on
          %msg        = new_message_with_text(
                          severity = if_abap_behv_message=>severity-error
                          text     = |La cantidad contada no puede ser negativa (Material { ls_item-Material }).|
                        )
        ) TO reported-detalleconteo.

        " Opcional: marcar el ítem como fallido
        APPEND VALUE #(
          %tky = ls_item-%tky
        ) TO failed-detalleconteo.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZR_CONTEO_HEAD_CAS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZR_CONTEO_HEAD_CAS IMPLEMENTATION.

  METHOD adjust_numbers.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
