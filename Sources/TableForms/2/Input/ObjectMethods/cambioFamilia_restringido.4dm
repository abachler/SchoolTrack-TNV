If (USR_checkRights ("M";->[Alumnos:2]))
	AL_fSave 
	$recNum:=Record number:C243([Familia:78])
	$FamNum:=[Familia:78]Numero:1
	$FamNombre:=[Familia:78]Nombre_de_la_familia:3
	vt_FamilyName:=ST_ClearSpaces ([Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4)
	$NewFamily:=AL_SelectFmlia 
	If ($newFamily#0)
		If ($FamNum#$NewFamily)
			$log:="El alumno(a) "+[Alumnos:2]apellidos_y_nombres:40+" fue cambiado de la familia "+$FamNombre+" a la familia "+[Familia:78]Nombre_de_la_familia:3+"."
			LOG_RegisterEvt ($log)
		End if 
		[Alumnos:2]Familia_Número:24:=$NewFamily
		SAVE RECORD:C53([Alumnos:2])  //20080902 RCH Cuando se cambiaba a un alumno de familia y se cumplían ciertas condiciones en el método AL_SelectFmlia el registro de alumnos nunca se guardaba.
		AL_OnRecordLoad (9)
	Else 
		GOTO RECORD:C242([Familia:78];$recNum)
	End if 
Else 
	$ignore:=CD_Dlog (0;__ ("Usted no dispone de los privilegios suficientes para realizar esta operación."))
End if 