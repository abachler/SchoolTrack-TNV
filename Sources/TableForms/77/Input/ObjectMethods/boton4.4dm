If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
	$recNumCta:=Record number:C243([ACT_CuentasCorrientes:175])
	$recNumAL:=Record number:C243([Alumnos:2])
End if 
vl_recordWasDeleted:=0
PUSH RECORD:C176([Familia_RelacionesFamiliares:77])
AL_MostrarApdo 
POP RECORD:C177([Familia_RelacionesFamiliares:77])
QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
vApNme:=[Personas:7]Apellidos_y_nombres:30
If (vl_recordWasDeleted=1)
	Case of 
		: ((Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78])) & ([Familia:78]Padre_Número:5=[Familia_RelacionesFamiliares:77]ID_Persona:3))
			[Familia:78]Padre_Número:5:=0
			[Familia:78]Padre_Nombre:15:=""
			SAVE RECORD:C53([Familia:78])
		: ((Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78])) & ([Familia:78]Madre_Número:6=[Familia_RelacionesFamiliares:77]ID_Persona:3))
			[Familia:78]Madre_Número:6:=0
			[Familia:78]Madre_Nombre:16:=""
			SAVE RECORD:C53([Familia:78])
		: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & ([Familia:78]Padre_Número:5=[Familia_RelacionesFamiliares:77]ID_Persona:3))
			[Familia:78]Padre_Número:5:=0
			[Familia:78]Padre_Nombre:15:=""
			SAVE RECORD:C53([Familia:78])
		: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & ([Familia:78]Madre_Número:6=[Familia_RelacionesFamiliares:77]ID_Persona:3))
			[Familia:78]Madre_Número:6:=0
			[Familia:78]Madre_Nombre:16:=""
	End case 
	SAVE RECORD:C53([Familia:78])
	DELETE RECORD:C58([Familia_RelacionesFamiliares:77])
	CANCEL:C270
End if 
vl_recordWasDeleted:=0

If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
	GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNumCta)
	GOTO RECORD:C242([Alumnos:2];$recNumAL)
End if 