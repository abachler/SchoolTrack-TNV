  // CIM_Principal.Botón10()
  // Por: Alberto Bachler K.: 02-11-14, 19:11:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($t_emailAviso)

If (Test semaphore:C652("CerrandoRespaldo"))
	ModernUI_Notificacion (__ ("Respaldo de base de datos");__ ("Se está procesando un respaldo de base de datos.\r\rPor favor intente nuevamente mas tarde."))
Else 
	CIM_BKP_GuardaPreferencias 
	$t_metodoOnError:=Method called on error:C704
	ON ERR CALL:C155("ERR_GenericOnError")
	BACKUP:C887
	ON ERR CALL:C155($t_metodoOnError)
	
	CIM_BKP_AnalisisLog 
End if 