$line:=AL_GetLine (xALP_ConsultasEnfermeria)
If (USR_checkRights ("D";->[Alumnos_EventosEnfermeria:14]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente borrar este registro?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		READ WRITE:C146([Alumnos_EventosEnfermeria:14])
		GOTO RECORD:C242([Alumnos_EventosEnfermeria:14];aCENo{$line})
		DELETE RECORD:C58([Alumnos_EventosEnfermeria:14])
		READ ONLY:C145([Alumnos_EventosEnfermeria:14])
		QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Alumno_Numero:1=[Alumnos:2]numero:1)
		AL_UpdateArrays (xALP_ConsultasEnfermeria;0)
		SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Fecha:2;aDateCE;[Alumnos_EventosEnfermeria:14]Afeccion:6;aMotCons;[Alumnos_EventosEnfermeria:14];aCENo;[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3;aCEHora)
		AL_UpdateArrays (xALP_ConsultasEnfermeria;Size of array:C274(aDateCE))
		IT_SetButtonState ((Size of array:C274(aDateCE)>0);->bDelSalud_Consulta)
	End if 
End if 