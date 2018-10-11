//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 27-02-17, 16:42:30
  // ----------------------------------------------------
  // Método: ST_verificaRelacionProfPers
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_LONGINT:C283($l_recnum;$v_resp)
C_TEXT:C284($mensaje;$t_accion;$t_rut)

$t_accion:=$1
$t_rut:=$2

If ($t_accion="relacion_familiar")
	$l_recnum:=Find in field:C653([Profesores:4]Numero:1;[Personas:7]ID_Profesor:78)
	If ($l_recnum>=0)
		GOTO RECORD:C242([Profesores:4];$l_recnum)
		$mensaje:=__ ("Este dato también estaba asociado al profesor ")+[Profesores:4]Apellidos_y_nombres:28+__ (". Si limpia o cambia el rut de esta persona será desvinculada de este registro de profesor. ¿Desea continuar?")
		$v_resp:=CD_Dlog (0;$mensaje;"";__ ("Desvincular");__ ("Cancelar"))
		If ($v_resp=2)
			[Personas:7]RUT:6:=Old:C35([Personas:7]RUT:6)
		End if 
	End if 
Else 
	$l_recnum:=Find in field:C653([Personas:7]ID_Profesor:78;[Profesores:4]Numero:1)
	If ($l_recnum>=0)
		GOTO RECORD:C242([Personas:7];$l_recnum)
		$mensaje:=__ ("Este dato también estaba asociado a la relación familiar ")+[Personas:7]Apellidos_y_nombres:30+__ (". Si limpia o cambia el rut de este profesor será desvinculado de esta relación familiar. ¿Desea continuar?")
		$v_resp:=CD_Dlog (0;$mensaje;"";__ ("Desvincular");__ ("Cancelar"))
		If ($v_resp=2)
			[Profesores:4]RUT:27:=Old:C35([Profesores:4]RUT:27)
		End if 
	End if 
End if 

