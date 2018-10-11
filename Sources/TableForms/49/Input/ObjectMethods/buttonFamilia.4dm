If (USR_checkRights ("M";->[Alumnos:2]))
	
	Case of 
		: (<>vlSTR_UsarSoloUnApellido=1)
			If (([Alumnos:2]Apellido_paterno:3#""))
				SAVE RECORD:C53([Familia:78])
				$recNum:=Record number:C243([Familia:78])
				$FamNum:=[Familia:78]Numero:1
				$FamNombre:=[Familia:78]Nombre_de_la_familia:3
				vt_FamilyName:=ST_ClearSpaces ([Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4)
				$NewFamily:=AL_SelectFmlia 
				If ($newFamily#0)
					If ($FamNum#$NewFamily)
						$log:="El candidato(a) "+[Alumnos:2]apellidos_y_nombres:40+" fue cambiado de la familia "+$FamNombre+" a la familia "+[Familia:78]Nombre_de_la_familia:3+"."
						LOG_RegisterEvt ($log)
					End if 
					[Alumnos:2]Familia_Número:24:=$NewFamily
					$fam:=Find in field:C653([Familia:78]Numero:1;$newFamily)
					GOTO RECORD:C242([Familia:78];$fam)
				Else 
					If ($recNum#-1)
						GOTO RECORD:C242([Familia:78];$recNum)
					End if 
				End if 
				vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
				PST_GetFamilyRelations 
				PST_SetConnexions 
				KRL_ReloadInReadWriteMode (->[Familia:78])
				OBJECT SET ENTERABLE:C238(*;"Family@";True:C214)
			Else 
				CD_Dlog (0;__ ("El candidato debe tener el primer apellido para poder ser asignado a una familia."))
			End if 
		Else 
			If (([Alumnos:2]Apellido_paterno:3#"") & ([Alumnos:2]Apellido_materno:4#""))
				SAVE RECORD:C53([Familia:78])
				$recNum:=Record number:C243([Familia:78])
				$FamNum:=[Familia:78]Numero:1
				$FamNombre:=[Familia:78]Nombre_de_la_familia:3
				vt_FamilyName:=ST_ClearSpaces ([Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4)
				$NewFamily:=AL_SelectFmlia 
				If ($newFamily#0)
					If ($FamNum#$NewFamily)
						$log:="El candidato(a) "+[Alumnos:2]apellidos_y_nombres:40+" fue cambiado de la familia "+$FamNombre+" a la familia "+[Familia:78]Nombre_de_la_familia:3+"."
						LOG_RegisterEvt ($log)
					End if 
					[Alumnos:2]Familia_Número:24:=$NewFamily
					$fam:=Find in field:C653([Familia:78]Numero:1;$newFamily)
					GOTO RECORD:C242([Familia:78];$fam)
				Else 
					If ($recNum#-1)
						GOTO RECORD:C242([Familia:78];$recNum)
					End if 
				End if 
				vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
				PST_GetFamilyRelations 
				PST_SetConnexions 
				KRL_ReloadInReadWriteMode (->[Familia:78])
				OBJECT SET ENTERABLE:C238(*;"Family@";True:C214)
			Else 
				CD_Dlog (0;__ ("El candidato debe tener definidos apellido paterno y materno antes de poder ser asignado a una familia."))
			End if 
	End case 
Else 
	$ignore:=CD_Dlog (0;__ ("Usted no dispone de los privilegios suficientes para realizar esta operación."))
End if 