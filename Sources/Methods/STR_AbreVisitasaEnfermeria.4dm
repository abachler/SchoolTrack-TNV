//%attributes = {}
  //STR_AbreVisitasaEnfermeria
If (Table:C252(yBWR_currentTable)=2)  //MONO 07-02-2013: al abrir el form desde otro panel hace el goto record a alumnos pero con un record number de otra tabla.
	Case of 
		: (Size of array:C274(abrSelect)>1)
			If (USR_checkRights ("A";->[Alumnos_EventosEnfermeria:14]))
				CD_Dlog (0;__ ("Hay más de un alumno en selección, se considerará el primero para el ingreso de Visita a Enfermería"))
				GOTO RECORD:C242([Alumnos:2];alBWR_RecordNumber{abrSelect{1}})
				vProfAutoriza:=""
				$title:=__ ("Ingreso de: ")+[Alumnos:2]Nombre_Común:30
				WDW_OpenFormWindow (->[Alumnos_EventosEnfermeria:14];"Input";-1;4;$title)
				FORM SET INPUT:C55([Alumnos_EventosEnfermeria:14];"Input")
				ADD RECORD:C56([Alumnos_EventosEnfermeria:14];*)
				CLOSE WINDOW:C154
			End if 
		: (Size of array:C274(abrSelect)=1)
			If (USR_checkRights ("A";->[Alumnos_EventosEnfermeria:14]))
				GOTO RECORD:C242([Alumnos:2];alBWR_RecordNumber{abrSelect{1}})
				vProfAutoriza:=""
				$title:=__ ("Ingreso de: ")+[Alumnos:2]Nombre_Común:30
				WDW_OpenFormWindow (->[Alumnos_EventosEnfermeria:14];"Input";-1;4;$title)
				FORM SET INPUT:C55([Alumnos_EventosEnfermeria:14];"Input")
				ADD RECORD:C56([Alumnos_EventosEnfermeria:14];*)
				CLOSE WINDOW:C154
			End if 
		Else 
			CD_Dlog (0;__ ("Debe seleccionar al menos un alumno para el ingreso de Visita a Enfermería."))
	End case 
Else 
	CD_Dlog (0;__ ("Debe seleccionar un registro desde el panel de Alumnos."))
End if 