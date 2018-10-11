//%attributes = {}
  //dbu_FixRepitencia

READ WRITE:C146([Alumnos:2])

QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta;*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<Nivel_Egresados)

SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)

For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
	QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2=<>GYear-1)
	If (Records in selection:C76([Alumnos_Historico:25])>0)
		If ([Alumnos_Historico:25]Situacion_final:19="R")
			[Alumnos:2]Es_Repitente:77:=True:C214
		Else 
			[Alumnos:2]Es_Repitente:77:=False:C215
		End if 
		SAVE RECORD:C53([Alumnos:2])
	End if 
End for 