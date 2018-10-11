//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 18-05-18, 11:07:36
  // ----------------------------------------------------
  // Método: STWA2_EliminaPdfInformesLCD
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($l_indice;$l_progress;$l_therm)
C_TEXT:C284($t_rutaAplicacion;$t_rutaDirectorio;$t_error)

ARRAY TEXT:C222($at_directorios;0)
$l_therm:=IT_UThermometer (1;0;"Verificando datos...")
$t_rutaAplicacion:=SYS_CarpetaAplicacion (CLG_Estructura)
$t_rutaDirectorio:=$t_rutaAplicacion+"Carpeta Web"+SYS_FolderDelimiterOnServer +"InformesLCD"
If (Test path name:C476($t_rutaDirectorio)=Is a folder:K24:2)  // 20180531 RCH
	FOLDER LIST:C473($t_rutaDirectorio;$at_directorios)
	$l_progress:=IT_Progress (1;0;0;"Eliminando informes LCD almacenados en el servidor")
	For ($l_indice;1;Size of array:C274($at_directorios))
		$l_progress:=IT_Progress (0;$l_progress;$l_indice/Size of array:C274($at_directorios);"Eliminando informes LCD almacenados en el servidor")
		
		  //20180706 ASM Ticket 211619
		  //DELETE FOLDER($t_rutaDirectorio+SYS_FolderDelimiterOnServer +$at_directorios{$l_indice};Delete with contents)
		$t_folder:=$t_rutaDirectorio+SYS_FolderDelimiterOnServer +$at_directorios{$l_indice}
		$t_error:=SYS_DeleteFolderOnServer ($t_folder;1)
		If ($t_error#"")
			$l_indice:=Size of array:C274($at_directorios)
		End if 
	End for 
	$l_progress:=IT_Progress (-1;$l_progress)
End if 
IT_UThermometer (-2;$l_therm)

If ($t_error#"")
	LOG_RegisterEvt ("Eliminación informes LCD: "+$t_error)
Else 
	LOG_RegisterEvt ("Eliminación informes LCD: Registros eliminados con éxito.")
End if 