C_LONGINT:C283($r)
TRACE:C157
Case of 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
		$rec:=-1
		$id:=-1
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
		$saved:=AL_fSave 
		$rec:=Record number:C243([Alumnos:2])
		$id:=[Alumnos:2]numero:1
		$idCust:=[Alumnos:2]ID_Custodio:99
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		$saved:=ACTcc_fSave 
		$rec:=-1
		$id:=[ACT_CuentasCorrientes:175]ID_Alumno:3
		$idCust:=[Alumnos:2]ID_Custodio:99
End case 
If ([Familia_RelacionesFamiliares:77]ID_Persona:3=0)
	DELETE RECORD:C58([Familia_RelacionesFamiliares:77])
	$go:=False:C215
Else 
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia_RelacionesFamiliares:77]ID_Familia:2)
	If ($rec>=0)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]numero:1#$id)
	End if 
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Familia_RelacionesFamiliares:77]ID_Persona:3;*)
	QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Apoderado_Cuentas_Número:28=[Familia_RelacionesFamiliares:77]ID_Persona:3)
	If (Records in selection:C76([Alumnos:2])>0)
		$r:=CD_Dlog (0;__ ("Esta persona es apoderado de un alumno de la familia.\rLa relación familiar no puede ser eliminada."))
		$go:=False:C215
	Else 
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Familia_RelacionesFamiliares:77]ID_Persona:3;*)
		QUERY:C277([ACT_CuentasCorrientes:175]; & [ACT_CuentasCorrientes:175]ID_Familia:2=[Familia_RelacionesFamiliares:77]ID_Familia:2)
		If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
			$r:=CD_Dlog (0;__ ("Esta persona es apoderado de cuenta de uno o más alumnos de la familia.\rLa relación familiar no puede ser eliminada."))
			$go:=False:C215
		Else 
			If ($idCust=[Familia_RelacionesFamiliares:77]ID_Persona:3)
				CD_Dlog (0;__ ("Esta persona es custodio del alumno. La relación no puede ser eliminada."))
				$go:=False:C215
			Else 
				$go:=True:C214
			End if 
		End if 
	End if 
End if 
If ($go=True:C214)
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar esta relación familiar?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		Case of 
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175])) & ([ACT_CuentasCorrientes:175]ID_Apoderado:9=[Familia_RelacionesFamiliares:77]ID_Persona:3))
				If (Not:C34(KRL_ReadWrite (->[Alumnos:2])))
					[Alumnos:2]Apoderado_académico_Número:27:=0
					[Alumnos:2]Apoderado_Cuentas_Número:28:=0
					$saved:=AL_fSave 
					[ACT_CuentasCorrientes:175]ID_Apoderado:9:=0
					ACTcc_fSave 
				End if 
			: (($rec>0) & ([Alumnos:2]Apoderado_académico_Número:27=[Familia_RelacionesFamiliares:77]ID_Persona:3) & ([Alumnos:2]Apoderado_Cuentas_Número:28=[Familia_RelacionesFamiliares:77]ID_Persona:3))
				GOTO RECORD:C242([Alumnos:2];$rec)
				[Alumnos:2]Apoderado_académico_Número:27:=0
				[Alumnos:2]Apoderado_Cuentas_Número:28:=0
				$saved:=AL_fSave 
			: (($rec>0) & ([Alumnos:2]Apoderado_Cuentas_Número:28=[Familia_RelacionesFamiliares:77]ID_Persona:3))
				READ WRITE:C146([Alumnos:2])
				GOTO RECORD:C242([Alumnos:2];$rec)
				[Alumnos:2]Apoderado_Cuentas_Número:28:=0
				$saved:=AL_fSave 
			: ($rec>0)
				READ WRITE:C146([Alumnos:2])
				GOTO RECORD:C242([Alumnos:2];$rec)
		End case 
		Case of 
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78])) & ([Familia:78]Padre_Número:5=[Familia_RelacionesFamiliares:77]ID_Persona:3))
				[Familia:78]Padre_Número:5:=0
				SAVE RECORD:C53([Familia:78])
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78])) & ([Familia:78]Madre_Número:6=[Familia_RelacionesFamiliares:77]ID_Persona:3))
				[Familia:78]Madre_Número:6:=0
				SAVE RECORD:C53([Familia:78])
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & ([Familia:78]Padre_Número:5=[Familia_RelacionesFamiliares:77]ID_Persona:3))
				[Familia:78]Padre_Número:5:=0
				SAVE RECORD:C53([Familia:78])
			: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & ([Familia:78]Madre_Número:6=[Familia_RelacionesFamiliares:77]ID_Persona:3))
				[Familia:78]Madre_Número:6:=0
		End case 
		SAVE RECORD:C53([Familia:78])
		$readOnly:=Read only state:C362([Personas:7])
		$rnPersona:=Record number:C243([Personas:7])
		READ ONLY:C145([Personas:7])
		QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
		$log:="Eliminación de "+[Familia_RelacionesFamiliares:77]Parentesco:6+" ("+[Personas:7]Apellidos_y_nombres:30+") en la familia "+[Familia:78]Nombre_de_la_familia:3+"."
		LOG_RegisterEvt ($log)
		DELETE RECORD:C58([Familia_RelacionesFamiliares:77])
		If (Not:C34($readOnly))
			READ WRITE:C146([Personas:7])
		End if 
		If ($rnPersona#-1)
			GOTO RECORD:C242([Personas:7];$rnPersona)
		End if 
		CANCEL:C270
	End if 
End if 


If ($rec>=0)
	Case of 
		: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
		: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
			READ WRITE:C146([Alumnos:2])
			GOTO RECORD:C242([Alumnos:2];$rec)
		: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
			READ WRITE:C146([ACT_CuentasCorrientes:175])
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$rec)
	End case 
End if 