  // CIM_Principal.BKP_integracionAutomaticaLog()
  // Por: Alberto Bachler K.: 24-07-15, 18:51:26
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$l_integrarHistorial:=(OBJECT Get pointer:C1124(Object current:K67:2))->
If ($l_integrarHistorial=0)
	$t_mensaje:=__ ("Si desactiva la integración del historial cuando la base de datos está incompleta es posible que se pierda información registrada por los usuarios que no ha sido almacenada "\
		+"antes del cierre inesperado de la base de datos o después de la restauración de un respaldo automático al detectarse algun daño en la base de datos.\r"\
		+"\rEs recomendable mantener la integración del historial activada.")
	ModernUI_Notificacion (__ ("Configuración de respaldo y restauración de la base de datos");$t_mensaje;__ ("Cancelar");__ ("Desactivar integración del historial"))
End if 