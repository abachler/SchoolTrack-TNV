//%attributes = {}
  //DIAG_HGradesSubjectNames

$pID:=IT_UThermometer (1;0;__ ("Verificando y reparando registros de notas históricas…"))

ALL RECORDS:C47([Asignaturas_Historico:84])
SELECTION TO ARRAY:C260([Asignaturas_Historico:84];$aRecNums)
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Asignaturas_Historico:84])
	GOTO RECORD:C242([Asignaturas_Historico:84];$aRecNums{$i})
	If ([Asignaturas_Historico:84]Sector:38="")
		$el:=Find in array:C230(<>aAsign;[Asignaturas_Historico:84]Asignatura:2)
		If ($el>0)
			[Asignaturas_Historico:84]Sector:38:=<>aAsignSector{$el}
		Else 
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1;=;[Asignaturas_Historico:84]ID_AsignaturaOriginal:30)
			If (Records in selection:C76([Asignaturas:18])>0)
				[Asignaturas_Historico:84]Sector:38:=[Asignaturas:18]Sector:9
			End if 
		End if 
		SAVE RECORD:C53([Asignaturas_Historico:84])
	End if 
End for 
IT_UThermometer (-2;$pID)